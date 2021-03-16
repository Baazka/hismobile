import 'package:flutter/material.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/data/models/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'avatar.dart';

Future<Employee> fetchEmpProfile() async {
  int userid;
  int id;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('UserID');
  id = prefs.getInt('EmployeeID');
  var res = await RestApi().getProfile(userid, id);
  if (isValidResponse(res)) {
    var _data = parseResponse(res);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      return Employee.fromJson(_data['ResponseData']['Employee']);
    }
  }
  return null;
}

class ProfileEmployee extends StatefulWidget {
  @override
  _ProfileEmployeeState createState() => _ProfileEmployeeState();
}

class _ProfileEmployeeState extends State<ProfileEmployee> {
  Future<Employee> employee;
  @override
  void initState() {
    super.initState();
    employee = fetchEmpProfile();
  }

  @override
  Widget build(BuildContext context) {
    //builder: (context) => PasswordRoute(usernameController))
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            side: new BorderSide(color: Colors.grey, width: 1.0),
          ),
          child: FutureBuilder<Employee>(
            future: employee,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Avatar(
                        filepath: snapshot.data.filePath,
                      ),
                    ),
                    title: Text(
                        '${snapshot.data.surName} ${snapshot.data.givenName.toUpperCase()}'),
                    subtitle: Text(
                        '${snapshot.data.code} / ${snapshot.data.statusName}'),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('${snapshot.data.divisionName}'),
                          Text(
                              '${snapshot.data.positionName} - ${snapshot.data.employmentTypeName}'),
                        ],
                      ),
                    ),
                  )
                ]);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}
