import 'package:flutter/material.dart';
import 'package:note_taker_app/models/AssignmentsProvider.dart';
import 'package:note_taker_app/models/TopicsProvider.dart';

class AssignmentForm extends StatefulWidget {
  int course_id;
  AssignmentForm(this.course_id);
  @override
  _AssignmentFormState createState() => _AssignmentFormState();
}

class _AssignmentFormState extends State<AssignmentForm> {
  String name;
  String description;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> HandleSubmit() async {
    if (_formKey.currentState.validate()) {
      AssignmentProvider assignment = AssignmentProvider(widget.course_id);
      await assignment
          .addAssignment(new Task(widget.course_id, name, description));
      Navigator.pop(context);
    } else
      return;
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        this.name = _nameController.text;
      });
    });
    _descriptionController.addListener(() {
      setState(() {
        this.description = _descriptionController.text;
      });
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value.length == 0)
                  return 'Enter Valid Text';
                else
                  return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              validator: (value) {
                if (value.length == 0)
                  return 'Enter Valid Text';
                else
                  return null;
              },
            ),
            FloatingActionButton(
              child: Text('Submit'),
              onPressed: () {
                HandleSubmit();
              },
            )
          ],
        ),
      ),
    );
  }
}
