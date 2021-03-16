import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/constants.dart';

Future<List<dynamic>> fetchData() async {
  List<dynamic> list;
  var value = await RestApi().getPaymentStudentData();
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      if (_data['ResponseData']['PaymentStudentDataList'] != null &&
          _data['ResponseData']['PaymentStudentDataList'] != '') {
        if (_data['ResponseData']['PaymentStudentDataList'] is List)
          list = _data['ResponseData']['PaymentStudentDataList'] as List;
        else
          list = _data['ResponseData']['PaymentStudentDataList'];
      }
    }
  }
  return list;
}

class StudentData extends StatefulWidget {
  @override
  _StudentDataState createState() => _StudentDataState();
}

class _StudentDataState extends State<StudentData> {
  Widget _getDataTable(List listOfData) {
    List<DataRow> rows = [];
    listOfData.forEach((row) {
      rows.add(DataRow(cells: [
        DataCell(Text('${row['VariableName']}')),
        DataCell(Align(
          alignment: Alignment.centerRight,
          child: row['Amount'] != null
              ? Text(formatDecimal.format(double.parse(row['Amount'])))
              : Text(''),
        )),
      ]));
    });

    return Card(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Үзүүлэлт',
            ),
          ),
          DataColumn(
            label: Text(
              'Дүн',
            ),
          ),
        ],
        rows: rows,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Төлбөрийн мэдээлэл')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<dynamic>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? _getDataTable(snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
