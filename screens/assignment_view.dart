import 'package:flutter/material.dart';
import 'package:note_taker_app/models/AssignmentsProvider.dart';
import 'package:note_taker_app/models/CourseProvider.dart';
import 'package:provider/provider.dart';

/*class AssignmentView extends StatelessWidget {
  int task_id;
  AssignmentView(this.task_id);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<AssignmentProvider>(create: (_) => AssignmentProvider()),
    ]);
  }
}*/

class AssignmentView extends StatelessWidget {
  Task task;
  AssignmentView(this.task);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Assignment Details'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(task.name),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            ),
            Container(
              child: Text(task.description),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            )
          ],
        ));
  }
}
