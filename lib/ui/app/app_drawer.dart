import 'package:flutter/material.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/data/models/auth.dart';
import 'package:flutter_login/ui/lockedscreen/home.dart';
import 'package:flutter_login/ui/lockedscreen/localtion.dart';
import 'package:flutter_login/ui/lockedscreen/newsList.dart';
import 'package:flutter_login/ui/signin/signin.dart';
import 'package:flutter_login/ui/student/grade.dart';
import 'package:flutter_login/ui/student/lesson/lesson.dart';
import 'package:flutter_login/ui/student/payment/payment.dart';
import 'package:flutter_login/ui/student/studentPlan.dart';
import 'package:flutter_login/ui/student/studentSinglePlan.dart';
import 'package:flutter_login/ui/lockedscreen/timeTable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawer createState() => _AppDrawer();
}

class _AppDrawer extends State<AppDrawer> {
  int roleID;

  @override
  void initState() {
    super.initState();
    _roleID();
  }

  _roleID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      roleID = (prefs.getInt('RoleID') ?? 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: true);
    return Drawer(
      child: SafeArea(
        // color: Colors.grey[50],
        child: ListView(
          children: <Widget>[
            Divider(),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 80,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text(
                'Нүүр',
                textScaleFactor: textScaleFactor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 16,
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                ),
              },
            ),
            if (roleID == 100)
              ListTile(
                leading: Icon(Icons.file_copy_outlined),
                title: Text(
                  'Сургалтын төлөвлөгөө',
                  textScaleFactor: textScaleFactor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentPlan()),
                  ),
                },
              ),
            if (roleID == 100)
              ListTile(
                leading: Icon(Icons.insert_drive_file_outlined),
                title: Text(
                  'Ганцаарчилсан төлөвлөгөө',
                  textScaleFactor: textScaleFactor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentSinglePlan()),
                  ),
                },
              ),
            if (roleID == 100)
              ListTile(
                leading: Icon(Icons.book_outlined),
                title: Text(
                  'Хичээл',
                  textScaleFactor: textScaleFactor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Lesson()),
                  ),
                },
              ),
            if (roleID == 100)
              ListTile(
                leading: Icon(Icons.payment_outlined),
                title: Text(
                  'Төлбөр',
                  textScaleFactor: textScaleFactor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Payment()),
                  ),
                },
              ),
            if (roleID == 100)
              ListTile(
                leading: Icon(Icons.timeline_outlined),
                title: Text(
                  'Дүн',
                  textScaleFactor: textScaleFactor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Grade()),
                  ),
                },
              ),
            ListTile(
              leading: Icon(Icons.event_note_outlined),
              title: Text(
                'Хуваарь',
                textScaleFactor: textScaleFactor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 16,
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimeTable()),
                ),
              },
            ),
            ListTile(
              leading: Icon(Icons.pin_drop_outlined),
              title: Text(
                'Байршил',
                textScaleFactor: textScaleFactor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 16,
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Location()),
                ),
              },
            ),
            ListTile(
              leading: Icon(Icons.library_books_outlined),
              title: Text(
                'Мэдээ',
                textScaleFactor: textScaleFactor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 16,
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsList()),
                ),
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app_outlined),
              title: Text(
                'Гарах',
                textScaleFactor: textScaleFactor,
              ),
              onTap: () => {
                _auth.logout(),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
                //usreh
              },
            ),
          ],
        ),
      ),
    );
  }
}
