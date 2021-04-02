import '../models/CourseProvider.dart';

class CourseScreenArgs {
  int id;
  String course_name;
  String course_description;
  CourseScreenArgs(this.id, this.course_name, this.course_description);
}

class EditCourseArgs {
  int id;
  String name;
  String description;
  int start_day;
  int start_month;
  int start_year;
  EditCourseArgs(this.id, this.name, this.description, this.start_day,
      this.start_month, this.start_year);
  EditCourseArgs.fromCourse(Course course) {
    this.id = course.id;
    this.name = course.name;
    this.description = course.description;
    this.start_day = course.start_day;
    this.start_month = course.start_month;
    this.start_year = course.start_year;
  }
}
