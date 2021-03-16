import 'package:flutter/material.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/data/models/studentGrade.dart';

void showAlertPopup(BuildContext context, String title, String detail) async {
  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showDemoDialog<Null>(
      context: context,
      child: AlertDialog(
        title: Text(title),
        content: Text(detail),
        actions: [
          FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ));
}

void showGradePopup(
    BuildContext context, String title, StudentGrade grade) async {
  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showDemoDialog<Null>(
      context: context,
      child: AlertDialog(
        content: DataTable(
          headingRowHeight: 0,
          columns: [DataColumn(label: Text('')), DataColumn(label: Text(''))],
          rows: [
            DataRow(cells: [
              DataCell(Text('Код')),
              DataCell(Text(grade.code ?? ''))
            ]),
            DataRow(cells: [
              DataCell(Text('Нэр')),
              DataCell(Text(grade.name ?? ''))
            ]),
            DataRow(cells: [
              DataCell(Text('Кр')),
              DataCell(Align(
                alignment: Alignment.centerRight,
                child: Text(
                  grade.credit != null
                      ? formatNumber.format(double.parse(grade.credit))
                      : '',
                ),
              ))
            ]),
            DataRow(cells: [
              DataCell(Text('Багшийн оноо')),
              DataCell(Align(
                alignment: Alignment.centerRight,
                child: Text(
                  grade.teacherScore != null
                      ? formatNumber.format(double.parse(grade.teacherScore))
                      : '',
                ),
              ))
            ]),
            DataRow(cells: [
              DataCell(Text('Шалгалтын оноо')),
              DataCell(Align(
                alignment: Alignment.centerRight,
                child: Text(
                  grade.examScore != null
                      ? formatNumber.format(double.parse(grade.examScore))
                      : '',
                ),
              ))
            ]),
            DataRow(cells: [
              DataCell(Text('Нийт оноо')),
              DataCell(Align(
                alignment: Alignment.centerRight,
                child: Text(
                  grade.totalScore != null
                      ? formatNumber.format(double.parse(grade.totalScore))
                      : '',
                ),
              ))
            ]),
            DataRow(cells: [
              DataCell(Text('Үнэлгээ')),
              DataCell(Align(
                alignment: Alignment.centerRight,
                child: Text(grade.grade ?? ''),
              ))
            ]),
            DataRow(cells: [
              DataCell(Text('Чанарын оноо')),
              DataCell(Align(
                alignment: Alignment.centerRight,
                child: Text(
                  grade.gpa != null
                      ? formatDecimal.format(double.parse(grade.gpa))
                      : '',
                ),
              ))
            ])
          ],
        ),
        actions: [
          FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ));
}
