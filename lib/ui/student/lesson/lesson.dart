import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/data/models/lesson.dart';
import 'package:flutter_login/ui/app/app_drawer.dart';
import 'package:flutter_login/ui/student/lesson/studentAttendance.dart';
import 'package:flutter_login/ui/student/lesson/studentProcessInstruction.dart';

Future<List<LessonList>> fetchData() async {
  List<LessonList> lessonlist = [];
  var value = await RestApi().getLessonList();
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      if (_data['ResponseData']['LessonList'] != '' &&
          _data['ResponseData']['LessonList'] != null) {
        if (_data['ResponseData']['LessonList'] is List) {
          var lesson = _data['ResponseData']['LessonList'] as List;
          lessonlist = lesson.map((data) => LessonList.fromJson(data)).toList();
        } else {
          lessonlist.add(
              new LessonList.fromJson(_data['ResponseData']['LessonList']));
        }
      }
    }
  }
  return lessonlist;
}

class Lesson extends StatefulWidget {
  @override
  _LessonState createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  Widget expansionTileWidget(List<LessonList> lesson) {
    List<Widget> widgets = new List<Widget>();
    List<Widget> widgets2 = new List<Widget>();
    List<Widget> widgets3 = new List<Widget>();
    var group = groupBy(lesson, (obj) => obj.lessonTypeID);
    group.forEach((key, value) {
      widgets.add(Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "${value.first.lessonTypeName.toUpperCase()}",
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
        widgets2.add(ExpansionTile(
          //subtitle: IconButton(icon: Icon(Icons.ac_unit), onPressed: null),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                    '${item.code} ${item.name} / ${formatNumber.format(double.parse(item.credit))}'),
              ),
            ],
          ),
          children: widgets3,
        ));
        if (int.parse(item.lessonTypeID) == 1) {
          widgets3.add(Row(
            children: [
              Expanded(
                  child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          StudentProcessInstruction(item)));
                },
                child: Text('Явцын дүн'),
              )),
              Expanded(
                  child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          StudentAttendance(item)));
                },
                child: Text('Ирц'),
              ))
            ],
          ));
        }

        if (item.teacherList != null) {
          item.teacherList.forEach((element) {
            widgets3.add(ListTile(
              title: element.typeName != null && element.groupID != null
                  ? Text(
                      '${element.typeName ?? ''}/${element.groupID ?? ''} ${element.teacherName}')
                  : Text('${element.teacherName}'),
            ));
          });
        }
        widgets3 = new List<Widget>();
      });
      widgets2 = new List<Widget>();
    });

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  // void _onTapItem(BuildContext context, Profession profession) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (BuildContext context) => StudentPlanDetail(profession)));
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Хичээл')),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: FutureBuilder<List<LessonList>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? expansionTileWidget(snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
