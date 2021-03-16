class ProfessionLessonList {
  final String rowNo;
  final String groupID;
  final String groupName;
  final String topGroupID;
  final String topGroupName;
  final String programLessonID;
  final String lessonID;
  final String code;
  final String name;
  final String credit;
  final String semesterName;
  final String isOptional;
  final String studentLessonID;
  final String sortOrder;
  final String sortColumn;

  ProfessionLessonList(
      {this.rowNo,
      this.groupID,
      this.groupName,
      this.topGroupID,
      this.topGroupName,
      this.programLessonID,
      this.lessonID,
      this.code,
      this.name,
      this.credit,
      this.semesterName,
      this.isOptional,
      this.studentLessonID,
      this.sortOrder,
      this.sortColumn});

  factory ProfessionLessonList.fromJson(Map<String, dynamic> json) {
    return new ProfessionLessonList(
      rowNo: json['RowNo'],
      groupID: json['GroupID'],
      groupName: json['GroupName'],
      topGroupID: json['TopGroupID'],
      topGroupName: json['TopGroupName'],
      programLessonID: json['ProgramLessonID'],
      lessonID: json['LessonID'],
      code: json['Code'],
      name: json['Name'],
      credit: json['Credit'],
      semesterName: json['SemesterName'],
      isOptional: json['IsOptional'],
      studentLessonID: json['StudentLessonID'],
      sortOrder: json['SortOrder'],
      sortColumn: json['SortColumn'],
    );
  }
}
