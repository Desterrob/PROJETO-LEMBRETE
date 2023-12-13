import 'package:flutter/material.dart';
import 'package:todo_list/views/home_page.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.teal)));
}

class HomePage {
  Constructor(title){
    this.title = title;
    this.tasks
  }

}

class Task {
  int id;
  String title;
  String description;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "isDone": isDone,
      };
}