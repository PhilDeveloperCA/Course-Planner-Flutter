//Wrap in Multi-Provider??
import 'package:flutter/material.dart';
import 'package:note_taker_app/models/AssignmentsProvider.dart';
import 'package:note_taker_app/models/CourseProvider.dart';
import 'package:note_taker_app/models/TopicsProvider.dart';
import 'package:note_taker_app/routes/route_names.dart';
import 'package:provider/provider.dart';
import 'package:note_taker_app/routes/route_args.dart';

class AssignmentArgs {
  CourseScreenArgs course;
  Task task;
  AssignmentArgs(this.course, this.task);
}

// ignore: non_constant_identifier_names
class CourseView extends StatefulWidget {
  Course course;
  CourseView(this.course);
  _CourseViewState createState() {
    return _CourseViewState();
  }
}

class _CourseViewState extends State<CourseView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return /*ChangeNotifierProvider(
      create: (context) => AssignmentProvider(widget.id),
      builder: (context, child) => Consumer<AssignmentProvider>(
        builder: (context, model, child) =>*/
        Scaffold(
      appBar: AppBar(title: Text('Course Screen ')),
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    if (index == 0) {
      return ChangeNotifierProvider(
          create: (context) => AssignmentProvider(widget.course.id),
          builder: (context, child) => CourseOverview());
    }
    if (index == 1) {
      return TopicsOverview();
    } else
      return TasksOverview();
  }

  Widget CourseOverview() {
    final course = Provider.of<CourseProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 18.0, bottom: 20.0),
              child: Text(
                widget.course.name,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  'Course Description : ',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[600]),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 18.0),
              child: Text(
                widget.course.description,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        bottom(
          Container(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.edit_course,
                          arguments: widget.course);
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Edit Course')),
                IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 40.0,
                  color: Colors.red[500],
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Are You Sure Want To Remove This Course'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FloatingActionButton.extended(
                            onPressed: () {
                              course.deleteCourse(widget.course.id);
                              Navigator.pop(context);
                            },
                            label: Text('Yes'),
                            icon: Icon(Icons.warning),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget TasksOverview() {
    return ChangeNotifierProvider(
      create: (context) => AssignmentProvider(widget.course.id),
      builder: (context, child) => Consumer<AssignmentProvider>(
        builder: (context, model, child) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: model.assignments
                  .map<Widget>(
                    (assignment) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${assignment.name}'),
                          FloatingActionButton.extended(
                            icon: Icon(Icons.details),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteNames.task_overview,
                                  arguments: assignment);
                            },
                            label: Text('Details'),
                          ),
                        ]),
                  )
                  .toList(),
            ),
            bottom(Container(
              padding: EdgeInsets.only(bottom: 18.0),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  print(model.assignments);
                  Navigator.pushNamed(context, RouteNames.add_assignment,
                      arguments: widget.course.id);
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget TopicsOverview() {
    return ChangeNotifierProvider(
      create: (context) => TopicProvider(widget.course.id),
      builder: (context, child) => Consumer<TopicProvider>(
        builder: (context, model, child) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 400,
                child: ListView.builder(
                    itemCount: model.topics.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${model.topics[index].name}'),
                                  FloatingActionButton.extended(
                                    icon: Icon(Icons.details),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RouteNames.topic_details,
                                          arguments: model.topics[index]);
                                    },
                                    label: Text('Details'),
                                  ),
                                ]),
                          ),
                        ],
                      );
                    })),
            /*Column(
              children: model.topics
                  .map<Widget>(
                    (assignment) => Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${assignment.name}'),
                            FloatingActionButton.extended(
                              icon: Icon(Icons.details),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteNames.topic_details,
                                    arguments: assignment);
                              },
                              label: Text('Details'),
                            ),
                          ]),
                    ),
                  )
                  .toList(),
            ),*/
            bottom(Container(
              padding: EdgeInsets.only(bottom: 18.0),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.add_topic,
                      arguments: widget.course.id);
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget bottom(Widget button) {
    return Column(
      children: [
        button,
        BottomNavigationBar(
          currentIndex: this.index,
          onTap: (value) {
            setState(() => index = value);
          },
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Topics',
              icon: Icon(Icons.topic),
            ),
            BottomNavigationBarItem(
              label: 'Assignments',
              icon: Icon(Icons.assignment),
            ),
          ],
        )
      ],
    );
  }
}
