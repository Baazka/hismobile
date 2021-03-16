import 'package:flutter/material.dart';
import 'package:flutter_login/api/restapi.dart';
import 'package:flutter_login/api/apihelper.dart';
import 'package:flutter_login/data/models/student.dart';
import 'package:flutter_login/ui/lockedscreen/avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Student> fetchProfile() async {
  int userid;
  int id;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid = prefs.getInt('UserID');
  id = prefs.getInt('StudentID');
  var res = await RestApi().getProfile(userid, id);
  if (isValidResponse(res)) {
    var _data = parseResponse(res);
    if (_data['ResponseData'] != null && _data['ResponseData'] != '') {
      return Student.fromJson(_data['ResponseData']['Student']);
    }
  }
  return null;
}

class ProfileStudent extends StatefulWidget {
  @override
  _ProfileStudentState createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> {
  Future<Student> student;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });
    student = fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    //builder: (context) => PasswordRoute(usernameController))
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(8.0),
          child: FutureBuilder<Student>(
            future: student,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
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
                          '${snapshot.data.studentCode} / ${snapshot.data.statusName}'),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                                '${snapshot.data.schoolName} \n${snapshot.data.departmentName}'),
                            Text('${snapshot.data.professionName}'),
                            Text(
                                '(${snapshot.data.trainingDegreeName}, ${snapshot.data.trainingTypeName})'),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
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
//  Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                           '${snapshot.data.surName} ${snapshot.data.givenName.toUpperCase()}'),
//                       Text(
//                           '${snapshot.data.schoolName} \n${snapshot.data.departmentName}'),
//                       Text(
//                           '${snapshot.data.professionNo} - ${snapshot.data.professionName} (${snapshot.data.trainingDegreeName}, ${snapshot.data.trainingTypeName})'),
//                       Text(
//                           '${snapshot.data.studentCode} / ${snapshot.data.statusName}'),
//                     ],
//                   )
