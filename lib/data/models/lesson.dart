class LessonList {
  final String lessonTypeID;
  final String lessonTypeName;
  final String lessonID;
  final String code;
  final String name;
  final String credit;
  final List<TeacherList> teacherList;

  LessonList(
      {this.lessonTypeID,
      this.lessonTypeName,
      this.lessonID,
      this.code,
      this.name,
      this.credit,
      this.teacherList});

  factory LessonList.fromJson(Map<String, dynamic> json) {
    List<TeacherList> teacherList = [];
    if (json["TeacherList"] is List) {
      var list = json['TeacherList'] as List;
      teacherList = list.map((data) => TeacherList.fromJson(data)).toList();
    } else {
      if (json["TeacherList"] != null)
        teacherList.add(new TeacherList.fromJson(json["TeacherList"]));
    }
    return new LessonList(
      lessonTypeID: json['LessonTypeID'],
      lessonTypeName: json['LessonTypeName'],
      lessonID: json['LessonID'],
      code: json['Code'],
      name: json['Name'],
      credit: json['Credit'],
      teacherList: teacherList,
    );
  }
}

class TeacherList {
  final String lessonID;
  final String teacherID;
  final String teacherCode;
  final String teacherName;
  final String lessonTypeID;
  final String teacherGroupID;
  final String groupID;
  final String typeID;
  final String typeName;

  TeacherList(
      {this.lessonID,
      this.teacherID,
      this.teacherCode,
      this.teacherName,
      this.lessonTypeID,
      this.teacherGroupID,
      this.groupID,
      this.typeID,
      this.typeName});

  factory TeacherList.fromJson(Map<String, dynamic> json) {
    return new TeacherList(
      lessonID: json['LessonID'],
      teacherID: json['TeacherID'],
      teacherCode: json['TeacherCode'],
      teacherName: json['TeacherName'],
      lessonTypeID: json['LessonTypeID'],
      teacherGroupID: json['TeacherGroupID'],
      groupID: json['GroupID'],
      typeID: json['TypeID'],
      typeName: json['TypeName'],
    );
  }
}
