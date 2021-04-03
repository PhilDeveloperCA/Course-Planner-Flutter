import 'package:note_taker_app/models/TopicsProvider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/AssignmentsProvider.dart';
import '../models/CourseProvider.dart';
import '../models/LinkProvider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;

  static Database _database;

  get helperDatabase => _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes7.db';

    var notesDatabase = await openDatabase(path,
        version: 2, onCreate: _createDb, onConfigure: _configureDb);
    return notesDatabase;
  }

  void _configureDb(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void _createDb(Database db, int newVersion) async {
    print('db initializing');
    await db.execute(
        'CREATE TABLE courses(id INTEGER PRIMARY KEY, name TEXT, description TEXT, start_day INTEGER, start_month INTEGER, start_year INTEGER, completed INTEGER)');
    await db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY, course_id INTEGER, name TEXT, description TEXT, FOREIGN KEY(course_id) REFERENCES courses(id) ON DELETE CASCADE)');
    await db.execute(
        'CREATE TABLE course_topics(id INTEGER PRIMARY KEY, course_id INTEGER, name TEXT, description TEXT, FOREIGN KEY(course_id) REFERENCES courses(id) ON DELETE CASCADE)');
    await db.execute(
        'CREATE TABLE topic_link(id INTEGER PRIMARY KEY, topic_id INTEGER, name TEXT, url TEXT, description TEXT, FOREIGN KEY(topic_id) REFERENCES course_topics(id) ON DELETE CASCADE)');
  }

  //COURSE ATTRIBUTES
  //ADD , Edit, Change Completion, DELETE
  Future<int> getMaxId(String table_name) async {
    Database db = await database;
    List<Map<String, dynamic>> id =
        await db.rawQuery('select max(id) FROM ${table_name}');
    int new_id = id[0]['max(id)'];
    new_id == null ? new_id = 1 : new_id++;
    return new_id;
  }

  Future<int> addCourse(Course course) async {
    Database db = await database;
    List<Map<String, dynamic>> id =
        await db.rawQuery(' SELECT max(id) FROM courses');
    int new_id = (id[0]['max(id)']) == null ? 1 : id[0]['max(id)'] + 1;
    int raw = await db.rawInsert(
        "INSERT INTO courses(id, name, description, start_day, start_month, start_year, completed)"
        "VALUES (?,?,?,?,?,?,?)",
        [
          new_id,
          course.name,
          course.description,
          course.start_day,
          course.start_month,
          course.start_year,
          course.completed == true ? 1 : 0
        ]);
    return raw;
  }

  Future<int> updateCourse(Course course) async {
    Database db = await database;
    await db.update('courses', course.coursetoMap(),
        where: 'id = ?', whereArgs: [course.id]);
  }

  Future<List<Course>> getCourses() async {
    Database db = await database;
    List<Map<String, dynamic>> raw = await db.rawQuery('SELECT * FROM courses');
    return raw.map((mapcourse) => Course.fromMap(mapcourse)).toList();
  }

  Future<Course> getCourseById(id) async {
    Database db = await database;
    List<Map<String, dynamic>> raw =
        await db.query('courses', where: 'id = ?', whereArgs: [id]);
    print(Course.fromMap(raw[0]));
    return Course.fromMap(raw[0]);
  }

  /*editCourseName(int id, String name) async {
    Database db = await database;
    await db.rawUpdate('UPDATE courses SET name = ? WHERE id = ?', [id, name]);
  }*/
  Future<void> deleteCourse(int id) async {
    Database db = await database;
    await db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }

  changeCourseCompletion(int id) async {
    Database db = await database;
    var completes =
        await db.rawQuery('SELECT completed FROM courses WHERE id = ? ', [id]);
    int completed = completes[0]['completed'] == 1 ? 0 : 1;
    await db.rawUpdate('UPDATE courses SET completed = ? WHERE id = ?', [
      completed,
      id,
    ]);
  }

  //TASK FEATURES
  //ADD, DELETE, MARK COMPLETE/INCOMPLETE, EDIT
  addTask(Task task) async {
    Database db = await database;
    var id = await db.rawQuery('SELECT MAX(id) FROM tasks');
    int max_id = id[0]['MAX(id)'];
    if (max_id == null)
      task.id = 1;
    else {
      max_id++;
      print(max_id);
      task.id = max_id;
    }
    await db.insert('tasks', task.TasktoMap());
  }

  Future<List<Task>> fetchTasks(course_id) async {
    Database db = await database;
    List<Map<String, dynamic>> tasks =
        await db.query('tasks', where: 'course_id = ?', whereArgs: [course_id]);
    return tasks.map((taskMap) => Task.fromMap(taskMap)).toList();
  }

  updateTask(Task task) async {
    Database db = await database;
    await db.update('tasks', task.TasktoMap(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  deleteTask(int id) async {
    Database db = await database;
    await db.delete('courses', where: 'id = ? ', whereArgs: [id]);
  }

  //Course Topics (Add, Delete) JUST FUCKING GET IT RIGHT
  addTopic(String name, String description, int course_id) async {
    int id = await getMaxId('course_topics');
    Database db = await database;
    print('here');
    await db.insert('course_topics', {
      'id': id,
      'name': name,
      'description': description,
      'course_id': course_id
    });
  }

  deleteTopic(int id) async {
    Database db = await database;
    await db.delete('course_topics', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Topic>> fetchTopics(int course_id) async {
    Database db = await database;
    var topics = await db.query('course_topics',
        where: 'course_id = ? ', whereArgs: [course_id]);
    return topics.map((taskMap) => Topic.fromMap(taskMap)).toList();
  }

  //Course Links
  addLink(Link link) async {
    int id = await getMaxId('topic_link');
    Database db = await database;
    await db.insert('topic_link', {
      'id': id,
      'url': link.url,
      'name': link.name,
      'description': link.description,
      'topic_id': link.topic_id,
    });
  }

  deleteLink(int id) async {
    Database db = await database;
    await db.delete('topic_link', where: 'id = ? ', whereArgs: [id]);
  }

  Future<List<Link>> getLinks(int topic_id) async {
    Database db = await database;
    var linksmaplist = await db
        .query('topic_link', where: 'topic_id = ? ', whereArgs: [topic_id]);
    List<Link> links =
        linksmaplist.map((linkmap) => Link.fromMap(linkmap)).toList();
    return links;
  }
}
