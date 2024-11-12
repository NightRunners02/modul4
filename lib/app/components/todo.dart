import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id; // ID dokumen dari Firestore
  String task;
  bool isDone;
  Timestamp createdOn;
  Timestamp updatedOn;

  Todo({
    required this.id,
    required this.task,
    required this.isDone,
    required this.createdOn,
    required this.updatedOn,
  });

  // Factory constructor untuk membuat instance dari JSON
  factory Todo.fromJson(Map<String, Object?> json, String id) {
    return Todo(
      id: id,
      task: json['task'] as String,
      isDone: json['isDone'] as bool,
      createdOn: json['createdOn'] as Timestamp,
      updatedOn: json['updatedOn'] as Timestamp,
    );
  }

  // Metode copyWith untuk membuat salinan dengan nilai yang diubah
  Todo copyWith({
    String? task,
    bool? isDone,
    Timestamp? createdOn,
    Timestamp? updatedOn,
  }) {
    return Todo(
      id: this.id,
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  // Konversi objek Todo ke dalam JSON untuk Firestore
  Map<String, Object?> toJson() {
    return {
      'task': task,
      'isDone': isDone,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
    };
  }
}
