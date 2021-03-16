class Student {
  final String personID;
  final String surName;
  final String givenName;
  final String registerNo;
  final String studentID;
  final String studentCode;
  final String studentName;
  final String phone;
  final String email;
  final String filePath;
  final String homeAddress;
  final String schoolCode;
  final String schoolName;
  final String departmentCode;
  final String departmentName;
  final String professionNo;
  final String professionName;
  final String trainingDegreeName;
  final String trainingTypeName;
  final String trainingLevelName;
  final String statusName;
  final String registeredDate;

  Student(
      {this.personID,
      this.surName,
      this.givenName,
      this.registerNo,
      this.studentID,
      this.studentCode,
      this.studentName,
      this.phone,
      this.email,
      this.filePath,
      this.homeAddress,
      this.schoolCode,
      this.schoolName,
      this.departmentCode,
      this.departmentName,
      this.professionNo,
      this.professionName,
      this.trainingDegreeName,
      this.trainingTypeName,
      this.trainingLevelName,
      this.statusName,
      this.registeredDate});

  factory Student.fromJson(Map<String, dynamic> json) {
    return new Student(
      personID: json['PersonID'],
      surName: json['SurName'],
      givenName: json['GivenName'],
      registerNo: json['RegisterNo'],
      studentID: json['StudentID'],
      studentCode: json['StudentCode'],
      studentName: json['StudentName'],
      phone: json['Phone'],
      email: json['Email'],
      filePath: json['FilePath'],
      homeAddress: json['HomeAddress'],
      schoolCode: json['SchoolCode'],
      schoolName: json['SchoolName'],
      departmentCode: json['DepartmentCode'],
      departmentName: json['DepartmentName'],
      professionNo: json['ProfessionNo'],
      professionName: json['ProfessionName'],
      trainingDegreeName: json['TrainingDegreeName'],
      trainingTypeName: json['TrainingTypeName'],
      trainingLevelName: json['TrainingLevelName'],
      statusName: json['StatusName'],
      registeredDate: json['RegisteredDate'],
    );
  }
}
