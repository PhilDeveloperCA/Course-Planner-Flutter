import 'dart:async';
import 'package:note_taker_app/models/CourseProvider.dart';
import 'package:rxdart/rxdart.dart';

import 'course_form_transform.dart';

class CourseBloc {
  //dynamic id;
  //bool completed;
  //Editing Fields
  final _name = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _start_day = BehaviorSubject<int>();
  final _start_month = BehaviorSubject<int>();
  final _start_year = BehaviorSubject<int>(); //make this parse int actually

  CourseBloc(Course course) {
    //this.id = course.id;
    //this.completed = course.completed;
    _name.sink.add(course.name);
    _description.sink.add(course.description);
    _start_day.sink.add(course.start_day);
    _start_month.sink.add(course.start_month);
    _start_year.sink.add(course.start_year);
  }

  //Stream Transformers
  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 0 && name != null && name.length < 255) {
      sink.add(name);
    } else {
      sink.addError('invalid name');
    }
  });

  final validateDescription = StreamTransformer<String, String>.fromHandlers(
      handleData: (description, sink) {
    if (description.length > 0 && description.length < 255) {
      sink.add(description);
    } else {
      sink.addError('Invalid Description');
    }
  });

  //Change Info on Stream
  Stream<String> get changeName => _name.stream.transform(validateName);
  Stream<String> get changeDescription =>
      _description.stream.transform(validateDescription);

  //Get info from Stream
  Stream<String> get name => _name.stream.transform(validateName);
  //handle submit on Widget level?
  /*submit() {
    if (id) {
      final course = new Course.withId(this.id, _name.value, _description.value,
          _start_day.value, _start_month.value, _start_year.value);
      
    }
  }*/
}
