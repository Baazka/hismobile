import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_login/scan.dart';
import 'package:flutter_login/ui/lockedscreen/profileEmployee.dart';
import 'package:flutter_login/ui/lockedscreen/profileStudent.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../app/app_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Нүүр",
          textScaleFactor: textScaleFactor,
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.settings),
        //     onPressed: () => Navigator.pushNamed(context, '/settings'),
        //   )
        // ],
      ),
      drawer: AppDrawer(),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: tabMenu(),
          body: TabBarView(
            children: [
              roleID == 100 ? ProfileStudent() : ProfileEmployee(),
              ScanPage(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget tabMenu() {
  return TabBar(
    labelColor: Colors.black54,
    unselectedLabelColor: Colors.blueGrey[100],
    indicatorSize: TabBarIndicatorSize.tab,
    //indicatorPadding: EdgeInsets.all(5.0),
    indicatorColor: Colors.blue,
    tabs: [
      Tab(
        icon: Icon(Icons.home),
      ),
      Tab(
        icon: Icon(Icons.qr_code),
      ),
    ],
  );
}
