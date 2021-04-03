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
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red[400],
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text(
                          'Are you Sure you want to Delete this assignment'),
                      actions: <Widget>[
                        FloatingActionButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            AssignmentProvider.delete2(task.id);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          label: Text('Yes'),
                          icon: Icon(Icons.warning),
                        )
                      ]),
                );
              },
            )
          ],
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
