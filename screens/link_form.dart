import 'package:flutter/material.dart';
import 'package:note_taker_app/models/LinkProvider.dart';
import 'package:provider/provider.dart';

class AddLink extends StatefulWidget {
  int topic_id;
  AddLink(this.topic_id);
  _AddLinkState createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
  String url = '';
  String description = '';
  String name = '';

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LinkProvider(widget.topic_id),
      builder: (context, child) => Scaffold(
          appBar: AppBar(
            title: Text('Add Link Form'),
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
                      model.addLink(new Link(widget.topic_id, this.name,
                          this.description, this.url));
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
