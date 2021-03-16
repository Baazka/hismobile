import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/constants.dart';

Future<List<dynamic>> fetchData() async {
  List<dynamic> list;
  var value = await RestApi().getPaymentStudentLesson();
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      if (_data['ResponseData']['PaymentStudentLessonList'] != null &&
          _data['ResponseData']['PaymentStudentLessonList'] != '') {
        if (_data['ResponseData']['PaymentStudentLessonList'] is List)
          list = _data['ResponseData']['PaymentStudentLessonList'] as List;
        else
          list = _data['ResponseData']['PaymentStudentLessonList'];
      }
    }
  }
  return list;
}

class StudentLesson extends StatefulWidget {
  @override
  _StudentLessonState createState() => _StudentLessonState();
}

class _StudentLessonState extends State<StudentLesson> {
  Widget _getList(List listOfData) {
    List<Widget> widgets = new List<Widget>();
    List<Widget> widgets2 = new List<Widget>();
    var group = groupBy(listOfData, (obj) => obj['LessonTypeID']);
    group.forEach((key, value) {
      widgets.add(Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                '${value.first['LessonTypeName'].toString().toUpperCase()}',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: widgets2,
            )
          ],
        ),
      ));
      value.forEach((item) {
        widgets2.add(
          ExpansionTile(
            title: Text('${item['Name']}'),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Хичээлийн код:"), Text('${item['Code']}')],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Хичээлийн кредит:"),
                    Text(item['Credit'] != null
                        ? formatNumber.format(double.parse(item['Credit']))
                        : '')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Кредит үнэлгээ:"),
                    Text(item['Amount'] != null
                        ? formatDecimal.format(double.parse(item['Amount']))
                        : ''),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Төлбөрийн дүн:"),
                    Text(item['CreditAmount'] != null
                        ? formatDecimal
                            .format(double.parse(item['CreditAmount']))
                        : ''),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Хөнгөлөх дүн:"),
                    Text(item['DiscountAmount'] != null
                        ? formatDecimal
                            .format(double.parse(item['DiscountAmount']))
                        : ''),
                  ],
                ),
              ),
            ],
          ),
        );
      });
      widgets2 = new List<Widget>();
    });

    return Column(
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Хичээл сонголт')),
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
        ),
      ),
    );
  }
}
