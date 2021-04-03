import 'package:flutter/cupertino.dart';
import 'package:note_taker_app/db/db.dart';

import 'CourseProvider.dart';

class Topic {
  int id;
  String name;
  int course_id;

  Topic(this.name, this.course_id);

  Topic.fromMap(Map<String, dynamic> topicmap) {
    this.id = topicmap['id'];
    this.name = topicmap['name'];
    this.course_id = topicmap['course_id'];
  }

  Future<Course> getCourse() async {
    Course course = await DatabaseHelper().getCourseById(this.course_id);
    return course;
  }
}

class TopicProvider extends ChangeNotifier {
  List<Topic> topics = [];
  int course_id;

  TopicProvider(course_id) {
    this.course_id = course_id;
    fetchCourses();
  }

  fetchCourses() async {
    this.topics = await DatabaseHelper().fetchTopics(this.course_id);
    notifyListeners();
  }

  addTopic(
    String name,
    String description,
  ) async {
    await DatabaseHelper().addTopic(name, description, this.course_id);
    fetchCourses();
  }

  deleteTopic(int id) async {
    await DatabaseHelper().deleteTopic(id);
    fetchCourses();
  }
}
