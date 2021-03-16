import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/constants.dart';

Future<List<dynamic>> fetchData() async {
  List<dynamic> list;
  var value = await RestApi().getPaymentStudentTransaction();
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      if (_data['ResponseData']['PaymentStudentTransactionList'] != null &&
          _data['ResponseData']['PaymentStudentTransactionList'] != '') {
        if (_data['ResponseData']['PaymentStudentTransactionList'] is List)
          list = _data['ResponseData']['PaymentStudentTransactionList'] as List;
        else
          list = _data['ResponseData']['PaymentStudentTransactionList'];
      }
    }
  }
  return list;
}

class StudentTransaction extends StatefulWidget {
  @override
  _StudentTransactionState createState() => _StudentTransactionState();
}

class _StudentTransactionState extends State<StudentTransaction> {
  Widget _getList(List listOfData) {
    List<Widget> widgets = new List<Widget>();
    List<Widget> widgets2 = new List<Widget>();
    var group = groupBy(listOfData, (v) => v['JournalDate']);
    group.forEach((key, value) {
      widgets.add(Card(
        child: ExpansionTile(
          leading: Icon(Icons.date_range_outlined),
          title: Text(
              '${formatDate.format(DateTime.parse(value.first['JournalDate']))} (${value.length})'),
          children: widgets2,
        ),
      ));
      value.forEach((elem) {
        widgets2.add(ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(elem['BankName']),
              Text(formatDecimal.format(double.parse(elem['Amount'] ?? ''))),
            ],
          ),
          subtitle: Text(elem['Narration']),
        ));
      });
      widgets2 = new List<Widget>();
    });

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Гүйлгээний мэдээлэл')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: FutureBuilder<List<dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? _getList(snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
      )),
    );
  }
}
