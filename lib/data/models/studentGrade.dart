class StudentGrade {
  final String lessonID;
  final String code;
  final String name;
  final String credit;
  final String studentGradeID;
  final String trainingPeriodID;
  final String trainingPeriodName;
  final String trainingSemesterID;
  final String trainingSemesterName;
  final String teacherScore;
  final String examScore;
  final String totalScore;
  final String gradeID;
  final String grade;
  final String gpa;
  final String gpaRate;
  final String gpaCredit;
  final String passedCredit;

  StudentGrade(
      {this.lessonID,
      this.code,
      this.name,
      this.credit,
      this.studentGradeID,
      this.trainingPeriodID,
      this.trainingPeriodName,
      this.trainingSemesterID,
      this.trainingSemesterName,
      this.teacherScore,
      this.examScore,
      this.totalScore,
      this.gradeID,
      this.grade,
      this.gpa,
      this.gpaRate,
      this.gpaCredit,
      this.passedCredit});

  factory StudentGrade.fromJson(Map<String, dynamic> json) {
    return new StudentGrade(
      lessonID: json['LessonID'],
      code: json['Code'],
      name: json['Name'],
      credit: json['Credit'],
      studentGradeID: json['StudentGradeID'],
      trainingPeriodID: json['TrainingPeriodID'],
      trainingPeriodName: json['TrainingPeriodName'],
      trainingSemesterID: json['TrainingSemesterID'],
      trainingSemesterName: json['TrainingSemesterName'],
      teacherScore: json['TeacherScore'],
      examScore: json['ExamScore'],
      totalScore: json['TotalScore'],
      gradeID: json['GradeID'],
      grade: json['Grade'],
      gpa: json['Gpa'],
      gpaRate: json['GpaRate'],
      gpaCredit: json['GpaCredit'],
      passedCredit: json['PassedCredit'],
    );
  }
}
