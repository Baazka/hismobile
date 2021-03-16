import 'package:flutter/material.dart';
import 'package:persist_theme/persist_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingState();
}

// Stateful widget for managing name data
class _SettingState extends State<SettingsPage> {
  bool isEmployee = false;
  @override
  void initState() {
    super.initState();
    getSwitchValues();
  }

  getSwitchValues() async {
    isEmployee = await getEmployee();
    setState(() {});
  }

  Future<bool> setEmployee(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isEmployee", value);
    //print('Switch Value saved $value');
    return prefs.setBool("isEmployee", value);
  }

  Future<bool> getEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEmployee = prefs.getBool("isEmployee") ?? false;
    //print(isEmployee);

    return isEmployee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Тохиргоо",
          textScaleFactor: textScaleFactor,
        ),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: ListBody(
          children: <Widget>[
            Container(
              height: 10.0,
            ),
            DarkModeSwitch(),
            ListTile(
                title: Text(
                  'Багш ажилтан',
                  textScaleFactor: textScaleFactor,
                ),
                trailing: Switch.adaptive(
                  value: isEmployee,
                  onChanged: (bool value) {
                    isEmployee = value;
                    setState(() {
                      isEmployee = value;
                      setEmployee(value);
                    });
                  },
                )),
            Divider(height: 20.0),
          ],
        ),
      )),
    );
  }
}
