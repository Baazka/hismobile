import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _roleID = "RoleID";
  static final String _studentID = "StudentID";
  static final String _employeeID = "EmployeeID";
  static final String _userID = "UserID";

  static Future<int> getRoleID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_roleID) ?? 0;
  }

  static Future<bool> setRoleID(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_roleID, value);
  }

  static Future<int> getStudentID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_studentID) ?? 0;
  }

  static Future<bool> setStudentID(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_studentID, value);
  }

  static Future<int> getEmployeeID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_employeeID) ?? 0;
  }

  static Future<bool> setEmployeeID(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_employeeID, value);
  }

  static Future<int> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userID) ?? 0;
  }

  static Future<bool> setUserID(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_userID, value);
  }
}
