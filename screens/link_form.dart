import 'package:flutter/material.dart';
import 'package:note_taker_app/models/CourseProvider.dart';
import 'package:note_taker_app/models/LinkProvider.dart';
import 'package:note_taker_app/models/TopicsProvider.dart';
import 'package:note_taker_app/routes/route_names.dart';
import 'package:provider/provider.dart';

class AddLink extends StatefulWidget {
  Topic topic;
  AddLink(this.topic);
  _AddLinkState createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
  String url = '';
  String description = '';
  String name = '';

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LinkProvider(widget.topic.id),
      builder: (context, child) => Scaffold(
          appBar: AppBar(
            title: Text('Add Link Form'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () async {
                  Course course = await widget.topic.getCourse();
                  Navigator.pushNamed(context, RouteNames.course_overview,
                      arguments: course);
                },
              )
            ],
          ),
          body: Form(
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      this.url = value;
                    });
                  },
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      this.name = value;
                    });
                  },
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      this.description = value;
                    });
                  },
                ),
                Consumer<LinkProvider>(
                  builder: (context, model, child) => FloatingActionButton(
                    onPressed: () {
                      model.addLink(new Link(widget.topic.id, this.name,
                          this.description, this.url));
                      Navigator.pushNamed(context, RouteNames.topic_details,
                          arguments: widget.topic);
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
