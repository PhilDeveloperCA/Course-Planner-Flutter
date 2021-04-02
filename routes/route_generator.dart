import 'package:flutter/material.dart';
import 'package:note_taker_app/routes/route_names.dart';
import 'package:note_taker_app/screens/add_assignment.dart';
import 'package:note_taker_app/screens/assignment_form.dart';
import 'package:note_taker_app/screens/assignment_view.dart';
import 'package:note_taker_app/screens/course_screen.dart';
import 'package:note_taker_app/screens/edit_course.dart';
import 'package:note_taker_app/screens/topic_form.dart';
import 'package:note_taker_app/screens/topic_screen.dart';
import '../screens/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (context) {
          return Home();
        });
      case RouteNames.edit_course:
        return MaterialPageRoute(builder: (context) {
          return EditCourse(settings.arguments);
        });
      /*case RouteNames.add_course:
        return MaterialPageRoute(builder: (context) {
          return EditCourse(settings.arguments);
        });*/
      case RouteNames.course_overview:
        return MaterialPageRoute(builder: (context) {
          return CourseView(args);
        });
      case RouteNames.task_overview:
        return MaterialPageRoute(builder: (context) => AssignmentView(args));
      case RouteNames.add_assignment:
        return MaterialPageRoute(builder: (context) => AssignmentForm(args));
      case RouteNames.edit_assignment:
        return MaterialPageRoute(builder: (context) => AddAssignment(args));
      case RouteNames.topic_details:
        return MaterialPageRoute(builder: (context) => TopicScreen(args));
      case RouteNames.add_topic:
        return MaterialPageRoute(builder: (context) => TopicForm(args));
      case RouteNames.link_details:
        return MaterialPageRoute(builder: (context) => CourseView(args));
      default:
        return MaterialPageRoute(builder: (context) => Home());
    }
  }
}
