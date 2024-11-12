import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tes/app/components/todo.dart'; // Import your new page

const String TODO_COLLECTION_REF = "todos";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Todo> _todosRef;

  DatabaseService() {
    _todosRef = _firestore.collection(TODO_COLLECTION_REF).withConverter<Todo>(
      fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!, snapshot.id),
      toFirestore: (todo, _) => todo.toJson(),
    );
  }

  // Stream untuk mendapatkan data Todo secara real-time
  Stream<QuerySnapshot<Todo>> getTodos() {
    return _todosRef.snapshots();
  }

  // Fungsi untuk menambahkan Todo
  Future<void> addTodo(Todo todo) async {
    try {
      await _todosRef.add(todo);
    } catch (e) {
      print("Error adding Todo: $e");
    }
  }

  // Fungsi untuk memperbarui Todo
  Future<void> updateTodo(String todoId, Todo todo) async {
    try {
      await _todosRef.doc(todoId).update(todo.toJson());
    } catch (e) {
      print("Error updating Todo: $e");
    }
  }

  // Fungsi untuk menghapus Todo
  Future<void> deleteTodo(String todoId) async {
    try {
      await _todosRef.doc(todoId).delete();
    } catch (e) {
      print("Error deleting Todo: $e");
    }
  }
}
