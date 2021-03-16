import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/data/models/lesson.dart';

Future<List<dynamic>> fetchData(int lessonid) async {
  List<dynamic> list;
  var value = await RestApi().getStudentTeacherGradeList(lessonid);
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      if (_data['ResponseData']['StudentTeacherGradeList'] != null &&
          _data['ResponseData']['StudentTeacherGradeList'] != '') {
        if (_data['ResponseData']['StudentTeacherGradeList'] is List)
          list = _data['ResponseData']['StudentTeacherGradeList'] as List;
        else
          list = _data['ResponseData']['StudentTeacherGradeList'];
      }
    }
  }
  return list;
}

class StudentProcessInstruction extends StatefulWidget {
  final LessonList item;
  StudentProcessInstruction(this.item);
  @override
  _StudentProcessInstructionState createState() =>
      _StudentProcessInstructionState();
}

class _StudentProcessInstructionState extends State<StudentProcessInstruction> {
  Widget _getDataTable(List listOfData) {
    List<DataRow> rows = [];
    listOfData.forEach((row) {
      rows.add(DataRow(cells: [
        DataCell(Text('${row['FormName']}')),
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(row['ScoreDate'] != null
              ? formatDate.format(DateTime.parse(row['ScoreDate']))
              : ''),
        )),
        DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text(row['FormScore'] != null
              ? formatNumber.format(double.parse(row['FormScore']))
              : ''),
        )),
        DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text(row['Score'] != null
              ? formatNumber.format(double.parse(row['Score']))
              : ''),
        )),
      ]));
    });

    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Үнэлгээ',
          ),
        ),
        DataColumn(
          label: Text(
            'Огноо',
          ),
        ),
        DataColumn(
          label: Text(
            'Нийт оноо',
          ),
        ),
        DataColumn(
          label: Text(
            'Оноо',
          ),
        ),
      ],
      rows: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Явцын дүн')),
        body: SafeArea(
          child: Column(
            children: [
              Card(
                child: Align(
                  alignment: Alignment.center,
                  child: ListTile(
                    title: Text('${widget.item.code} ${widget.item.name}'),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    child: FutureBuilder<List<dynamic>>(
                      future: fetchData(int.parse(widget.item.lessonID)),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? _getDataTable(snapshot.data)
                            : Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
