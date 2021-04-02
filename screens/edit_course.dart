import 'package:flutter/material.dart';
import 'package:note_taker_app/models/CourseProvider.dart';
import 'package:provider/provider.dart';

List<int> days = new List<int>.generate(31, (i) => i + 1);
List<int> months = new List<int>.generate(12, (index) => index + 1);

class EditCourse extends StatefulWidget {
  Course course;
  EditCourse(this.course);
  @override
  _EditCourseState createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  @override
  Widget build(BuildContext context) {
    final courseController = Provider.of<CourseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('Edit / Create Course'),
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.course.name,
                  onChanged: (value) {
                    setState(() {
                      widget.course.name = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: widget.course.description,
                  onChanged: (value) {
                    setState(() {
                      widget.course.description = value;
                    });
                  },
                ),
                DropdownButton(
                    value: widget.course.start_day,
                    onChanged: (value) {
                      setState(() {
                        widget.course.start_day = value;
                      });
                    },
                    items: days
                        .map<DropdownMenuItem>(
                          (day) => DropdownMenuItem(
                            child: Text('${day}'),
                            value: day,
                          ),
                        )
                        .toList()),
                DropdownButton(
                  items: months
                      .map<DropdownMenuItem>(
                        (month) => DropdownMenuItem(
                            child: Text('${month}'), value: month),
                      )
                      .toList(),
                  value: widget.course.start_month,
                  onChanged: (value) {
                    setState(() {
                      widget.course.start_month = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: widget.course.start_year.toString(),
                  onChanged: (value) {
                    setState(() {
                      widget.course.start_year = int.parse(value);
                    });
                  },
                )
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              courseController.addCourse(widget.course);
              Navigator.pushNamed(context, '/');
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }
}
