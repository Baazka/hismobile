import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class RestApi {
  Client client = new Client();
  Future<dynamic> signIn(String userName, String userCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEmployee = prefs.getBool("isEmployee") ?? false;

    Response res = await client.post(
        apiURL +
            (isEmployee ? '/Employee/Login' : '/Student/Login') +
            '?userName=' +
            userName +
            '&userCode=' +
            userCode,
        headers: {
          'Content-Type': 'application/xml',
        });
    return res;
  }

  Future<dynamic> getProfile(int userid, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEmployee = prefs.getBool("isEmployee") ?? false;

    Response res = await client.get(
        apiURL +
            (isEmployee ? '/Employee' : '/Student') +
            '/Profile/$userid/$id',
        headers: {
          'Content-Type': 'application/xml',
        });
    return res;
  }

  Future<dynamic> getProfessionList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("StudentID");
    Response res =
        await client.get(apiURL + '/Student/ProfessionList/$id', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }

  Future<dynamic> getProfessionLessonList(int programid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("StudentID");
    Response res = await client
        .get(apiURL + '/Student/ProfessionLessonList/$id/$programid', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }

  Future<dynamic> getStudentProgramList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("StudentID");
    Response res =
        await client.get(apiURL + '/Student/ProgramDetail/$id', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }

  Future<dynamic> getPaymentStudentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("StudentID");
    Response res = await client
        .get(apiURL + '/Student/PaymentStudentDataList/$id', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }

  Future<dynamic> getPaymentStudentLesson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("StudentID");
    Response res = await client
        .get(apiURL + '/Student/PaymentStudentLessonList/$id', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }

  Future<dynamic> getPaymentStudentTransaction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("StudentID");
    Response res = await client
        .get(apiURL + '/Student/PaymentStudentTransactionList/$id', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }

  Future<dynamic> getLessonList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("StudentID");
    Response res =
        await client.get(apiURL + '/Student/LessonList/$id', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }

  Future<dynamic> getStudentTeacherGradeList(int lessonid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("StudentID");
    Response res = await client
        .get(apiURL + '/Student/TeacherGradeList/$id/$lessonid', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }

  Future<dynamic> getStudentTeacherJournalList(int lessonid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("StudentID");
    Response res = await client
        .get(apiURL + '/Student/TeacherJournalList/$id/$lessonid', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }

  Future<dynamic> getStudentGradeList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt("StudentID");
    Response res =
        await client.get(apiURL + '/Student/GradeList/$id', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }

  Future<dynamic> getTimeTableList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int roleID = prefs.getInt("RoleID");
    int id;
    String url;
    if (roleID == 100) {
      id = prefs.getInt("StudentID");
      url = "/Student";
    } else {
      id = prefs.getInt("EmployeeID");
      url = "/Teacher";
    }
    Response res =
        await client.get(apiURL + url + '/TimetableList/$id', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }

  Future<dynamic> getNewsList(int pageno) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEmployee = prefs.getBool("isEmployee") ?? false;
    int userid = prefs.getInt("UserID");
    bool isAll = true;
    bool isStudent = true;
    bool isTeacher = true;
    isEmployee ? isStudent = false : isTeacher = false;
    Response res = await client.get(
        apiURL + 'News/List/$userid/$isAll/$isStudent/$isTeacher/$pageno',
        headers: {
          'Content-Type': 'application/xml',
        });
    return res;
  }

  Future<dynamic> getNewsDetails(int newsid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt("UserID");
    Response res =
        await client.get(apiURL + 'News/Detail/$userid/$newsid', headers: {
      'Content-Type': 'application/xml',
    });
    return res;
  }
}
