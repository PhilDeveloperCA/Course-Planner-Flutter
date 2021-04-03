import 'package:flutter/material.dart';
import 'package:note_taker_app/models/AssignmentsProvider.dart';
import 'package:note_taker_app/routes/route_names.dart';
import 'package:provider/provider.dart';

class AddAssignment extends StatefulWidget {
  Task task;
  AddAssignment(this.task);
  _AddAssignmentState createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AssignmentProvider(widget.task.course_id),
      builder: (context, child) => Scaffold(
        appBar: AppBar(title: Text('Add Task')),
        body: Form(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    widget.task.description;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  setState(() {
                    widget.task.name;
                  });
                },
              ),
              FloatingActionButton(onPressed: () {
                final model =
                    Provider.of<AssignmentProvider>(context, listen: false);
                model.addAssignment(widget.task);
                Navigator.pushNamed(context, RouteNames.course_overview,
                    arguments: widget.task.course_id);
              })
            ],
          ),
        ),
      ),
    );
  }
}
