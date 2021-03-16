import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/data/models/lesson.dart';

Future<List<dynamic>> fetchData(int lessonid) async {
  List<dynamic> list;
  var value = await RestApi().getStudentTeacherJournalList(lessonid);
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      if (_data['ResponseData']['StudentTeacherJournalList'] != null &&
          _data['ResponseData']['StudentTeacherJournalList'] != '') {
        if (_data['ResponseData']['StudentTeacherJournalList'] is List)
          list = _data['ResponseData']['StudentTeacherJournalList'] as List;
        else
          list = _data['ResponseData']['StudentTeacherJournalList'];
      }
    }
  }
  return list;
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class StudentAttendance extends StatefulWidget {
  final LessonList item;
  StudentAttendance(this.item);
  @override
  _StudentAttendanceState createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  Widget _getDataTable(List listOfData) {
    List<DataRow> rows = [];
    listOfData.forEach((row) {
      rows.add(DataRow(cells: [
        // StatusColor
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(row['JournalDate'] != null
              ? formatDate.format(DateTime.parse(row['JournalDate']))
              : ''),
        )),
        DataCell(Text(row['Subject'] ?? '')),
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(row['TypeName'] ?? ''),
        )),
        DataCell(
          Container(
            color: row['StatusColor'].toString().toColor(),
            child: Text(row['StatusName'] ?? ''),
          ),
        ),
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(row['Point'] ?? ''),
        )),
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(row['Comments'] ?? ''),
        )),
      ]));
    });

    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Огноо',
          ),
        ),
        DataColumn(
          label: Text(
            'Сэдэв',
          ),
        ),
        DataColumn(
          label: Text(
            'Төрөл',
          ),
        ),
        DataColumn(
          label: Text(
            'Ирц',
          ),
        ),
        DataColumn(
          label: Text(
            'Идэвхи',
          ),
        ),
        DataColumn(
          label: Text(
            'Нэмэлт',
          ),
        ),
      ],
      rows: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ирц')),
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
      ),
    );
  }
}
