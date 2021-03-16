import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/data/models/profession.dart';
import 'package:flutter_login/ui/app/app_drawer.dart';
import 'package:flutter_login/ui/student/studentPlanDetail.dart';

Future<List<Profession>> fetchData() async {
  List<Profession> pros = [];
  var value = await RestApi().getProfessionList();
  if (isValidResponse(value)) {
    var _data = parseResponse(value);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      if (_data['ResponseData']['StudentProfessionList'] != null &&
          _data['ResponseData']['StudentProfessionList'] != '') {
        if (_data['ResponseData']['StudentProfessionList'] is List) {
          var list = _data['ResponseData']['StudentProfessionList'] as List;
          pros = list.map((data) => Profession.fromJson(data)).toList();
        } else {
          pros.add(new Profession.fromJson(
              _data['ResponseData']['StudentProfessionList']));
        }
      }
    }
  }
  return pros;
}

class StudentPlan extends StatefulWidget {
  @override
  _StudentPlanState createState() => _StudentPlanState();
}

class _StudentPlanState extends State<StudentPlan> {
  @override
  void initState() {
    super.initState();
  }

  Widget listViewWidget(List<Profession> prof) {
    return Container(
      child: ListView.builder(
          itemCount: prof.length,
          itemBuilder: (context, position) {
            return Card(
              child: ListTile(
                title: Text(
                  '${prof[position].professionName}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${prof[position].trainingDegreeName}, ${prof[position].trainingTypeName} - ${prof[position].statusName}',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                ),
                onTap: () => _onTapItem(context, prof[position]),
                selected: (prof[position].isDefault != null ? true : false),
              ),
            );
          }),
    );
  }

  void _onTapItem(BuildContext context, Profession profession) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => StudentPlanDetail(profession)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сургалтын төлөвлөгөө'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<Profession>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? listViewWidget(snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
