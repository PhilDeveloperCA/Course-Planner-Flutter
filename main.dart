import 'package:flutter/material.dart';
import 'package:note_taker_app/routes/route_generator.dart';
import 'package:note_taker_app/routes/route_names.dart';
import 'package:provider/provider.dart';

import 'models/CourseProvider.dart';
/*
  1. Add and Display Courses (still here lol)
  2. Completed / Not-Completed Screens (Stateful Widget)
  3. Add Task / Assignments to Course
  4. Add Topics to Course 
  5. Add Links to Topics 
  6. Add Topics to Assignments
  7. Pagination 
  8. Stateful Widge Going between Tasks / Assignments
*/

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CourseProvider(),
      child: MaterialApp(
        initialRoute: RouteNames.home,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
