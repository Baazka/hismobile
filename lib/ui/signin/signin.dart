import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../data/models/auth.dart';
import '../../sharedpref.dart';
import '../../utils/popUp.dart';
// import 'forgot.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.username});

  final String username;

  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String _status = 'no-action';
  String _username, _password;

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _controllerUsername, _controllerPassword;

  @override
  initState() {
    _controllerUsername = TextEditingController(text: widget?.username ?? "");
    _controllerPassword = TextEditingController();
    _loadUsername();
    super.initState();
    print(_status);
  }

  void _loadUsername() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("saved_username") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      if (_remeberMe) {
        _controllerUsername.text = _username ?? "";
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          key: PageStorageKey("Divider 1"),
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              alignment: Alignment.centerRight,
            ),
            SizedBox(
              height: 220.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Нэвтрэх нэр'),
                      validator: (val) =>
                          val.length < 1 ? 'Нэвтрэх нэр хоосон байна' : null,
                      onSaved: (val) => _username = val,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      controller: _controllerUsername,
                      autocorrect: false,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Нууц үг'),
                      validator: (val) =>
                          val.length < 1 ? 'Нууц үг хоосон байна' : null,
                      onSaved: (val) => _password = val,
                      obscureText: true,
                      controller: _controllerPassword,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Намайг сана',
                textScaleFactor: textScaleFactor,
              ),
              trailing: Switch.adaptive(
                onChanged: _auth.handleRememberMe,
                value: _auth.rememberMe,
              ),
            ),
            ListTile(
              title: RaisedButton(
                child: Text(
                  'Нэвтрэх',
                  textScaleFactor: textScaleFactor,
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    final snackbar = SnackBar(
                      duration: Duration(seconds: 30),
                      content: Row(
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Text("  Нэвтэрч байна...")
                        ],
                      ),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackbar);

                    setState(() => this._status = 'loading');
                    _auth
                        .loginData(
                      username: _username.toString().trim(),
                      password: _password.toString().trim(),
                    )
                        .then((result) {
                      if (result['ResponseData'] != null) {
                        if (result['ResponseData']['Status'] != null) {
                          if (result['ResponseData']['Status']
                                  .toString()
                                  .toLowerCase() ==
                              'true')
                            print(result);
                          else {
                            setState(() => this._status = 'rejected');
                            showAlertPopup(context, 'Мэдээлэл',
                                result['ResponseData']['Message'].toString());
                          }
                        } else {
                          _setData(result['ResponseData']);
                          Navigator.pushNamed(context, '/home');
                        }
                      }
                      _scaffoldKey.currentState.hideCurrentSnackBar();
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setData(var loginData) async {
    SharedPreferencesHelper.setUserID(
        int.parse(loginData['SystemUser']['UserID']));
    SharedPreferencesHelper.setRoleID(
        int.parse(loginData['SystemUser']['RoleID']));
    if (loginData['SystemUser']['StudentID'] != null)
      SharedPreferencesHelper.setStudentID(
          int.parse(loginData['SystemUser']['StudentID'] ?? 0));
    if (loginData['SystemUser']['EmployeeID'] != null)
      SharedPreferencesHelper.setEmployeeID(
          int.parse(loginData['SystemUser']['EmployeeID'] ?? 0));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(loginData));
    //print(loginData);
  }
}
