class Employee {
  final String personID;
  final String surName;
  final String givenName;
  final String registerNo;
  final String code;
  final String phone;
  final String email;
  final String filePath;
  final String homeAddress;
  final String employmentDate;
  final String divisionName;
  final String positionName;
  final String employmentTypeName;
  final String statusName;

  Employee(
      {this.personID,
      this.surName,
      this.givenName,
      this.registerNo,
      this.code,
      this.phone,
      this.email,
      this.filePath,
      this.homeAddress,
      this.employmentDate,
      this.divisionName,
      this.positionName,
      this.employmentTypeName,
      this.statusName});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return new Employee(
      personID: json['PersonID'],
      surName: json['SurName'],
      givenName: json['GivenName'],
      registerNo: json['RegisterNo'],
      code: json['Code'],
      phone: json['Phone'],
      email: json['Email'],
      filePath: json['FilePath'],
      homeAddress: json['HomeAddress'],
      employmentDate: json['EmploymentDate'],
      divisionName: json['DivisionName'],
      positionName: json['PositionName'],
      employmentTypeName: json['EmploymentTypeName'],
      statusName: json['StatusName'],
    );
  }
}
