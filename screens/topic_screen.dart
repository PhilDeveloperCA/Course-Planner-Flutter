import 'package:flutter/material.dart';
import 'package:note_taker_app/models/CourseProvider.dart';
import 'package:note_taker_app/models/LinkProvider.dart';
import 'package:note_taker_app/models/TopicsProvider.dart';
import 'package:note_taker_app/routes/route_names.dart';
import 'package:provider/provider.dart';

class TopicScreen extends StatelessWidget {
  Topic topic;
  TopicScreen(this.topic);

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LinkProvider(this.topic.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Topic Link Page'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () async {
                Course course = await topic.getCourse();
                Navigator.pushNamed(context, RouteNames.course_overview,
                    arguments: course);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Consumer<LinkProvider>(
              builder: (context, model, child) => Column(
                children: model.links
                    .map(
                      (link) => Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${link.url} '),
                            Text('${link.name}'),
                            FloatingActionButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteNames.link_details,
                                    arguments: link);
                              },
                              child: Text('See Link Details'),
                            ),
                            FloatingActionButton(
                              child: Text('Delete'),
                              onPressed: () {
                                model.deleteLink(link.id);
                              },
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text('Add Link'),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.add_link,
                    arguments: topic);
              },
            )
          ],
        ),
      ),
    );
  }
}
