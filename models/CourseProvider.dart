import 'package:flutter/foundation.dart';
import '../db/db.dart';

class Course {
  int id;
  String name;
  String description; //add SQLLite Blobs with picture
  int start_day;
  int start_month;
  int start_year;
  //Date completed_date;
  bool completed;
  Course(this.name, this.description, this.start_day, this.start_month,
      this.start_year,
      {this.completed: false});

  Course.withId(this.id, this.name, this.description, this.start_day,
      this.start_month, this.start_year,
      {this.completed: false});

  Course.fromScratch() {
    this.name = '';
    this.description = '';
    this.start_day = 1;
    this.start_month = 1;
    this.start_year = 2021;
  }

  Course.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.description = map['description'];
    this.completed = map['completed'] == 1 ? true : false;
    if (map['completed'] == true) {
      print('Found One !!');
    }
  }

  Map<String, dynamic> coursetoMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'start_day': this.start_day,
      'start_month': this.start_month,
      'start_year': this.start_year,
      'completed': this.completed == true ? 1 : 0
    };
  }
}

class CourseProvider extends ChangeNotifier {
  List<Course> _courses = [];
  CourseProvider() {
    updateCourses();
  }

  get courses => this._courses;

  updateCourses() async {
    this._courses = await DatabaseHelper().getCourses();
    notifyListeners();
  }

  addCourse(Course course) async {
    if (course.id == null) {
      int result = await DatabaseHelper().addCourse(course);
    } else {
      int result = await DatabaseHelper().updateCourse(course);
    }

    updateCourses();
  }

  void changeCompletion(int id) async {
    await DatabaseHelper().changeCourseCompletion(id);
    await updateCourses();
  }

  void deleteCourse(int id) async {
    await DatabaseHelper().deleteCourse(id);
    await updateCourses();
  }
}

//full inserts for everything/ create and edit  equivalent operation
//Except for completed / not completed
