import 'package:flutter/foundation.dart';
import 'package:note_taker_app/db/db.dart';

class Task {
  int id;
  int course_id;
  String name;
  String description;

  Task(this.course_id, this.name, this.description);
  Task.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.course_id = map['course_id'];
    this.name = map['name'];
    this.description = map['description'];
  }

  Map<String, dynamic> TasktoMap() {
    return {
      'id': this.id,
      'course_id': this.course_id,
      'name': this.name,
      'description': this.description,
    };
  }

  Task.fromScratch(int course_id) {
    this.id = null;
    this.course_id = course_id;
    this.name = '';
    this.description = '';
  }
}

class AssignmentProvider extends ChangeNotifier {
  int course_id;
  List<Task> assignments = [];

  AssignmentProvider(int course_id) {
    this.course_id = course_id;
    fetchAssignments();
  }

  fetchAssignments() async {
    this.assignments = await DatabaseHelper().fetchTasks(this.course_id);
    notifyListeners();
  }

  addAssignment(Task task) async {
    if (task.id == null) {
      await DatabaseHelper().addTask(task);
    } else {
      DatabaseHelper().updateTask(task);
    }
    fetchAssignments();
  }

  delete(int id) async {
    await DatabaseHelper().deleteTask(id);
    fetchAssignments();
  }

  static delete2(int id) async {
    await DatabaseHelper().deleteTask(id);
  }
}
