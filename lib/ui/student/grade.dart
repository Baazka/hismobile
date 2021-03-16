import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/data/models/studentGrade.dart';
import 'package:flutter_login/ui/app/app_drawer.dart';
import 'package:flutter_login/utils/popUp.dart';

Future<List<StudentGrade>> fetchData() async {
  List<StudentGrade> pros = [];
  var value = await RestApi().getStudentGradeList();
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      if (_data['ResponseData']['StudentGradeList'] is List) {
        var list = _data['ResponseData']['StudentGradeList'] as List;
        pros = list.map((data) => StudentGrade.fromJson(data)).toList();
      } else {
        pros.add(new StudentGrade.fromJson(
            _data['ResponseData']['StudentGradeList']));
      }
    }
  }
  return pros;
}

class Grade extends StatefulWidget {
  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> {
  Widget listViewWidget(List<StudentGrade> grade) {
    List<Widget> widgets = new List<Widget>();
    List<Widget> subwidgets = new List<Widget>();
    var group = groupBy(grade, (obj) => obj.trainingPeriodID);
    double sumCredit = grade.length > 0
        ? grade.map((m) => double.parse(m.credit)).reduce((a, b) => a + b)
        : 0;
    double sumPassedCredit = grade.length > 0
        ? grade
            .map((m) => double.parse(m.passedCredit ?? "0"))
            .reduce((a, b) => a + b)
        : 0;
    double avgTotalScore = grade.length > 0
        ? grade.map((m) => double.parse(m.totalScore)).reduce((a, b) => a + b) /
            grade.length
        : 0;
    double gpa = 0;
    if (grade.length > 0) {
      var sumgpaRate = grade
          .map((m) => double.parse(m.gpaRate ?? "0"))
          .reduce((a, b) => a + b);
      var sumgpaCredit = grade
          .map((m) => double.parse(m.gpaCredit ?? "0"))
          .reduce((a, b) => a + b);
      gpa =
          sumgpaRate != 0 && sumgpaCredit != 0 ? sumgpaRate / sumgpaCredit : 0;
    }
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
                      formatNumber.format(sumCredit),
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    Text('Судалсан кредит'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      formatNumber.format(sumPassedCredit),
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    Text('Тооцсон кредит'),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      formatDecimal.format(gpa),
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    Text('Голч дүн'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      formatNumber.format(avgTotalScore),
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    Text('Дундаж оноо'),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ));
    group.forEach((key, value) {
      var subgroup = groupBy(value, (obj) => obj.trainingSemesterID);

      subgroup.forEach((key, value) {
        double sumGroupCredit = value.length > 0
            ? value.map((m) => double.parse(m.credit)).reduce((a, b) => a + b)
            : 0;
        double sumGroupPassedCredit = value.length > 0
            ? value
                .map((m) => double.parse(m.passedCredit ?? "0"))
                .reduce((a, b) => a + b)
            : 0;
        double gpaGroup;
        if (value.length > 0) {
          double sumgpaRate = value
              .map((m) => double.parse(m.gpaRate ?? "0"))
              .reduce((a, b) => a + b);
          double sumgpaCredit = value
              .map((m) => double.parse(m.gpaCredit ?? "0"))
              .reduce((a, b) => a + b);
          gpaGroup = sumgpaRate != 0 && sumgpaCredit != 0
              ? sumgpaRate / sumgpaCredit
              : 0;
        }
        double avgGroupTotalScore = value.length > 0
            ? value
                    .map((m) => double.parse(m.totalScore))
                    .reduce((a, b) => a + b) /
                value.length
            : 0;
        widgets.add(
          Card(
            child: ExpansionTile(
              leading: Icon(
                Icons.list_alt_outlined,
              ),
              title: Text(
                  '${value.first.trainingPeriodName}, ${value.first.trainingSemesterName}'),
              children: subwidgets,
            ),
          ),
        );
        subwidgets.add(
          ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Судалсан кредит:'),
                    Text(formatNumber.format(sumGroupCredit)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Тооцсон кредит:'),
                    Text(formatNumber.format(sumGroupPassedCredit)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Голч дүн:'),
                    Text(formatDecimal.format(gpaGroup)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Дундаж оноо:'),
                    Text(formatNumber.format(avgGroupTotalScore)),
                  ],
                )
              ],
            ),
          ),
        );
        List<DataRow> rows = [];
        subwidgets.add(DataTable(columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Нэр',
            ),
          ),
          DataColumn(
            label: Text(
              'Дүн',
            ),
          ),
          DataColumn(
            label: Text(
              'Үнэлгээ',
            ),
          ),
        ], rows: rows));
        value.forEach((item) {
          rows.add(
            DataRow(
              cells: [
                DataCell(
                  Text(
                    '${item.code} ${item.name} / ${formatNumber.format(double.parse(item.credit))}',
                  ),
                  onTap: () {
                    showGradePopup(context, 'Мэдээлэл', item);
                  },
                ),
                DataCell(
                  Center(
                    child: Text(
                      formatNumber.format(double.parse(item.totalScore)),
                      style: TextStyle(
                        color: (double.parse(item.passedCredit ?? "0")) == 0
                            ? Colors.red
                            : null,
                      ),
                    ),
                  ),
                ),
                DataCell(Center(
                  child: Text(
                    item.grade,
                    style: TextStyle(
                      color: (double.parse(item.passedCredit ?? "0")) == 0
                          ? Colors.red
                          : null,
                    ),
                  ),
                )),
              ],
            ),
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
      appBar: AppBar(title: Text('Дүн')),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: FutureBuilder<List<StudentGrade>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? listViewWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
