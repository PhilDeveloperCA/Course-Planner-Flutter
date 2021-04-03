import 'package:flutter/material.dart';
import 'package:note_taker_app/models/CourseProvider.dart';
import 'package:note_taker_app/routes/route_names.dart';
import 'package:provider/provider.dart';
import 'package:note_taker_app/routes/route_args.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  //screens all, completed, incomplete (state)
  int index = 0;
  String course_setting = "All";

  bool CompletionFilter(bool completed) {
    if (this.index == 0) return true;
    if (this.index == 2) {
      return completed;
    } else
      return !completed;
  }

  @override
  Widget build(BuildContext context) {
    CourseProvider courses =
        Provider.of<CourseProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Text(
              'Course Home Page',
              style: TextStyle(
                color: Colors.blue[500],
                backgroundColor: Colors.blue[50],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              child: Text(
                '${course_setting} Courses',
                style: TextStyle(fontSize: 20.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0),
            ),
            Consumer<CourseProvider>(
              builder: (context, model, child) => Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: model.courses
                        .where((i) => CompletionFilter(i.completed))
                        .toList()
                        .map<Widget>((course) => CourseWidget(course, model))
                        .toList(),
                  ),
                ),
              ),
            ),
          ]),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.edit_course,
                        arguments: new Course.fromScratch());
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                ),
              ),
              //CourseWidget(this.course_setting),
              BottomNavigationBar(
                  currentIndex: this.index,
                  onTap: (index) {
                    setState(() {
                      this.index = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.all_inbox),
                      label: 'All',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.all_inbox),
                      label: 'In Progress',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.all_inbox),
                      label: 'Completed',
                    )
                  ]),
            ],
          )
        ],
      ),
    );
  }
}

class CourseWidget extends StatelessWidget {
  Course status;
  CourseProvider checked;

  CourseWidget(Course this.status, this.checked);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(status.name),
        //Text('${status.start_day}'),
        FloatingActionButton.extended(
          icon: Icon(Icons.details),
          label: Text('Details'),
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.course_overview,
                arguments: status);
          },
        )
      ],
    );
  }
}

//Bloc Logic Should be easy, right???
