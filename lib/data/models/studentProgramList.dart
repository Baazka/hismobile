class StudentProgramList {
  final String lessonID;
  final String code;
  final String name;
  final String credit;
  final String studentProgramID;
  final String programID;
  final String trainingPeriodID;
  final String trainingPeriodName;
  final String trainingSemesterID;
  final String trainingSemesterName;

  StudentProgramList(
      {this.lessonID,
      this.code,
      this.name,
      this.credit,
      this.studentProgramID,
      this.programID,
      this.trainingPeriodID,
      this.trainingPeriodName,
      this.trainingSemesterID,
      this.trainingSemesterName});

  factory StudentProgramList.fromJson(Map<String, dynamic> json) {
    return new StudentProgramList(
      lessonID: json['LessonID'],
      code: json['Code'],
      name: json['Name'],
      credit: json['Credit'],
      studentProgramID: json['StudentProgramID'],
      programID: json['ProgramID'],
      trainingPeriodID: json['TrainingPeriodID'],
      trainingPeriodName: json['TrainingPeriodName'],
      trainingSemesterID: json['TrainingSemesterID'],
      trainingSemesterName: json['TrainingSemesterName'],
    );
  }
}
