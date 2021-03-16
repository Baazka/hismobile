class Profession {
  final String studentProfessionID;
  final String programID;
  final String registeredDate;
  final String schoolCode;
  final String departmentCode;
  final String professionName;
  final String trainingDegreeName;
  final String trainingTypeName;
  final String trainingLevelName;
  final String statusName;
  final String isDefault;

  Profession(
      {this.studentProfessionID,
      this.programID,
      this.registeredDate,
      this.schoolCode,
      this.departmentCode,
      this.professionName,
      this.trainingDegreeName,
      this.trainingTypeName,
      this.trainingLevelName,
      this.statusName,
      this.isDefault});

  factory Profession.fromJson(Map<String, dynamic> json) {
    return new Profession(
      studentProfessionID: json['StudentProfessionID'],
      programID: json['ProgramID'],
      registeredDate: json['RegisteredDate'],
      schoolCode: json['SchoolCode'],
      departmentCode: json['DepartmentCode'],
      professionName: json['ProfessionName'],
      trainingDegreeName: json['TrainingDegreeName'],
      trainingTypeName: json['TrainingTypeName'],
      trainingLevelName: json['TrainingLevelName'],
      statusName: json['StatusName'],
      isDefault: json['IsDefault'],
    );
  }
}
