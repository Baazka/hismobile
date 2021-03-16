class TrainingWeekDayList {
  final String weekDayID;
  final String name;
  final List<LessonTimetableList> timeTableList;

  TrainingWeekDayList({this.weekDayID, this.name, this.timeTableList});

  factory TrainingWeekDayList.fromJson(Map<String, dynamic> json) {
    List<LessonTimetableList> timetablelist = [];
    if (json["LessonTimetableList"] is List) {
      var list = json['LessonTimetableList'] as List;
      timetablelist =
          list.map((data) => LessonTimetableList.fromJson(data)).toList();
    } else {
      if (json["LessonTimetableList"] != null)
        timetablelist
            .add(new LessonTimetableList.fromJson(json["LessonTimetableList"]));
    }
    return new TrainingWeekDayList(
      weekDayID: json['WeekDayID'],
      name: json['Name'],
      timeTableList: timetablelist,
    );
  }
}

class LessonTimetableList {
  final String timetableID;
  final String teacherGroupID;
  final String sectionID;
  final String code;
  final String name;
  final String teacherCode;
  final String teacherName;
  final String roomNo;
  final String typeCode;
  final String typeName;
  final String typeColor;
  final String groupID;
  final String timeID;
  final String weekDayID;
  final String weekTypeID;
  final String weekTypeCode;
  final String weekTypeName;

  LessonTimetableList(
      {this.timetableID,
      this.teacherGroupID,
      this.sectionID,
      this.code,
      this.name,
      this.teacherCode,
      this.teacherName,
      this.roomNo,
      this.typeCode,
      this.typeName,
      this.typeColor,
      this.groupID,
      this.timeID,
      this.weekDayID,
      this.weekTypeID,
      this.weekTypeCode,
      this.weekTypeName});

  factory LessonTimetableList.fromJson(Map<String, dynamic> json) {
    return new LessonTimetableList(
      timetableID: json['TimetableID'],
      teacherGroupID: json['TeacherGroupID'],
      sectionID: json['SectionID'],
      code: json['Code'],
      name: json['Name'],
      teacherCode: json['TeacherCode'],
      teacherName: json['TeacherName'],
      roomNo: json['RoomNo'],
      typeCode: json['TypeCode'],
      typeName: json['TypeName'],
      typeColor: json['TypeColor'],
      groupID: json['GroupID'],
      timeID: json['TimeID'],
      weekDayID: json['WeekDayID'],
      weekTypeID: json['WeekTypeID'],
      weekTypeCode: json['WeekTypeCode'],
      weekTypeName: json['WeekTypeName'],
    );
  }
}
