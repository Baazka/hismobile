import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/data/models/timetable.dart';
import 'package:flutter_login/ui/app/app_drawer.dart';

Future<List<TrainingWeekDayList>> fetchData() async {
  List<TrainingWeekDayList> pros = [];
  var value = await RestApi().getTimeTableList();
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      if (_data['ResponseData']['TrainingWeekDayList'] != null &&
          _data['ResponseData']['TrainingWeekDayList'] != '') {
        if (_data['ResponseData']['TrainingWeekDayList'] is List) {
          var list = _data['ResponseData']['TrainingWeekDayList'] as List;
          pros =
              list.map((data) => TrainingWeekDayList.fromJson(data)).toList();
        } else {
          pros.add(new TrainingWeekDayList.fromJson(
              _data['ResponseData']['TrainingWeekDayList']));
        }
      }
    }
  }
  return pros;
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

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  Widget listViewWidget(List<TrainingWeekDayList> grade) {
    List<Widget> widgets = new List<Widget>();
    grade.forEach((e) {
      if (e.timeTableList.length != 0) {
        widgets.add(Card(
          child: ListTile(
            title: Align(
              alignment: Alignment.center,
              child: Text('${e.name}'.toUpperCase()),
            ),
          ),
        ));
        e.timeTableList.forEach((i) {
          widgets.add(Card(
            borderOnForeground: true,
            child: ListTile(
                tileColor: '${i.typeColor}'.toColor(),
                leading: Text(
                  '${i.timeID}',
                  style: TextStyle(fontSize: 55),
                ),
                isThreeLine: true,
                title: Text('${i.name} \n${i.roomNo}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${i.typeName} / ${i.groupID}',
                      style: TextStyle(
                          backgroundColor: '${i.typeColor}'.toColor()),
                    ),
                    Text('${i.teacherName ?? ''} ${i.weekTypeName ?? ''} '),
                  ],
                )),
          ));
        });
      }
    });
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Хичээлийн хуваарь')),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: FutureBuilder<List<TrainingWeekDayList>>(
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
