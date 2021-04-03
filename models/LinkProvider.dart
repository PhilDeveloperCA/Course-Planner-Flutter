import 'package:flutter/foundation.dart';
import 'package:note_taker_app/db/db.dart';

class Link {
  int id;
  int topic_id;
  String name;
  String description;
  String url;
  Link(this.topic_id, this.name, this.description, this.url);
  Link.fromMap(Map<String, dynamic> linkMap) {
    this.id = linkMap['id'];
    this.url = linkMap['url'];
    this.topic_id = linkMap['topic_id'];
    this.description = linkMap['description'];
    this.name = linkMap['name'];
  }
}

class LinkProvider extends ChangeNotifier {
  List<Link> links = [];
  int topic_id;
  LinkProvider(int topic_id) {
    this.topic_id = topic_id;
    this.links = [];
    fetchLinks();
  }

  fetchLinks() async {
    this.links = await DatabaseHelper().getLinks(this.topic_id);
    notifyListeners();
  }

  addLink(Link link) async {
    await DatabaseHelper().addLink(link);
    fetchLinks();
  }

  deleteLink(int id) async {
    await DatabaseHelper().deleteLink(id);
    fetchLinks();
  }
}
