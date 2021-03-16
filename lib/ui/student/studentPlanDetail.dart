import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/data/models/profession.dart';
import 'package:flutter_login/data/models/professionLessonList.dart';

Future<List<ProfessionLessonList>> fetchData(int programid) async {
  List<ProfessionLessonList> pros = [];
  var value = await RestApi().getProfessionLessonList(programid);
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      if (_data['ResponseData']['ProfessionLessonList'] != null &&
          _data['ResponseData']['ProfessionLessonList'] != '') {
        if (_data['ResponseData']['ProfessionLessonList'] is List) {
          var list = _data['ResponseData']['ProfessionLessonList'] as List;
          pros =
              list.map((data) => ProfessionLessonList.fromJson(data)).toList();
        } else {
          pros.add(new ProfessionLessonList.fromJson(
              _data['ResponseData']['ProfessionLessonList']));
        }
      }
    }
  }
  return pros;
}

class StudentPlanDetail extends StatefulWidget {
  final Profession profession;
  StudentPlanDetail(this.profession);
  @override
  _StudentPlanDetailState createState() => _StudentPlanDetailState();
}

class _StudentPlanDetailState extends State<StudentPlanDetail> {
  Widget tableWidget(List<ProfessionLessonList> prof) {
    List<DataRow> rows = [];
    var d = groupBy(prof, (v) => v.groupID);
    d.forEach((key, value) {
      rows.add(
        DataRow(cells: [
          DataCell(Center(
              child: Text(
            '${value.first.groupName}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ))),
          DataCell(Center(
            child: Text(formatNumber.format(double.parse(value.first.credit))),
          )),
        ]),
      );
      var t = groupBy(value.where((element) => element.topGroupID == key),
          (s) => s.groupID);
      t.forEach((key, value) {
        value.forEach((value) {
          rows.add(DataRow(cells: [
            DataCell(
                Text('${value.code} ${value.name}\n${value.semesterName}')),
            DataCell(Center(
              child: Text(formatNumber.format(double.parse(value.credit))),
            )),
          ]));
        });
      });
    });

    return Card(
        margin: const EdgeInsets.all(8.0),
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Нэр',
              ),
            ),
            DataColumn(
              label: Text(
                'Кр',
              ),
            ),
          ],
          rows: rows,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profession.professionName),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('${widget.profession.professionName}'),
              subtitle: Text(
                  '${widget.profession.trainingDegreeName}, ${widget.profession.trainingTypeName}'),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder<List<ProfessionLessonList>>(
                future: fetchData(int.parse(widget.profession.programID)),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? tableWidget(snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
