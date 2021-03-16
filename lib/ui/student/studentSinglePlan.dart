import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/data/models/studentProgramList.dart';
import 'package:flutter_login/ui/app/app_drawer.dart';

Future<List<StudentProgramList>> fetchData() async {
  List<StudentProgramList> pros = [];
  var value = await RestApi().getStudentProgramList();
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      if (_data['ResponseData']['StudentProgramList'] != '' &&
          _data['ResponseData']['StudentProgramList'] != null) {
        if (_data['ResponseData']['StudentProgramList'] is List) {
          var list = _data['ResponseData']['StudentProgramList'] as List;
          pros = list.map((data) => StudentProgramList.fromJson(data)).toList();
        } else {
          pros.add(new StudentProgramList.fromJson(
              _data['ResponseData']['StudentProgramList']));
        }
      }
    }
  }
  return pros;
}

class StudentSinglePlan extends StatefulWidget {
  @override
  _StudentSinglePlanState createState() => _StudentSinglePlanState();
}

class _StudentSinglePlanState extends State<StudentSinglePlan> {
  Widget listViewWidget(List<StudentProgramList> lesson) {
    List<Widget> widgets = new List<Widget>();
    List<Widget> subwidgets = new List<Widget>();
    List<DataRow> rows = [];
    var group = groupBy(lesson, (obj) => obj.trainingPeriodID);
    double sumCredit = lesson.length > 0
        ? lesson.map((m) => double.parse(m.credit)).reduce((a, b) => a + b)
        : 0;
    widgets.add(Card(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      '${lesson.length}',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    Text('Нийт хичээл'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      formatNumber.format(sumCredit),
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    Text('Нийт кредит'),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ));
    group.forEach((key, value) {
      var subgroup = groupBy(value, (obj) => obj.trainingSemesterID);
      subgroup.forEach((key, value) {
        widgets.add(Card(
          child: ExpansionTile(
            leading: Icon(
              Icons.list_alt_outlined,
            ),
            title: Text(
                '${value.first.trainingPeriodName}, ${value.first.trainingSemesterName}'),
            children: subwidgets,
          ),
        ));
        subwidgets.add(DataTable(columns: const <DataColumn>[
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
        ], rows: rows));
        value.forEach((item) {
          rows.add(
            DataRow(cells: [
              DataCell(Text(
                '${item.code} ${item.name}',
              )),
              DataCell(Center(
                child: Text(formatNumber.format(double.parse(item.credit))),
              )),
            ]),
          );
        });
        rows = [];
        subwidgets = new List<Widget>();
      });
    });
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ганцаарчилсан төлөвлөгөө'),
      ),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text('Хөтөлбөр: ${widget.profession.professionName}'),
          // Text('Зэрэг: ${widget.profession.trainingDegreeName}'),
          // Text('Хэлбэр: ${widget.profession.trainingTypeName}'),
          SizedBox(height: 10),
          Expanded(
              child: SingleChildScrollView(
            child: FutureBuilder<List<StudentProgramList>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? listViewWidget(snapshot.data)
                    : Center(child: CircularProgressIndicator());
              },
            ),
          ))
        ],
      ),
    );
  }
}
