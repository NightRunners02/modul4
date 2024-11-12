import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tes/app/components/todo.dart'; // Import your new page

class TodoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable untuk menyimpan daftar todo dari Firestore
  var todos = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodos(); // Ambil data dari Firestore saat inisialisasi
  }

  // Fungsi untuk menambahkan todo ke Firestore
  Future<void> addTodo(String task) async {
    Timestamp now = Timestamp.now();
    DocumentReference docRef = await _firestore.collection('todos').add({
      'task': task,
      'isDone': false,
      'createdOn': now,
      'updatedOn': now,
    });

    todos.add(Todo(
      id: docRef.id,
      task: task,
      isDone: false,
      createdOn: now,
      updatedOn: now,
    ));
  }

  // Fungsi untuk mengambil data todo dari Firestore
  void fetchTodos() async {
    QuerySnapshot snapshot = await _firestore.collection('todos').get();
    todos.value = snapshot.docs.map((doc) {
      return Todo.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // Fungsi untuk memperbarui todo di Firestore
  Future<void> updateTodo(String id, String newTask, bool isDone) async {
    Timestamp now = Timestamp.now();
    await _firestore.collection('todos').doc(id).update({
      'task': newTask,
      'isDone': isDone,
      'updatedOn': now,
    });

    int index = todos.indexWhere((element) => element.id == id);
    if (index != -1) {
      todos[index] = todos[index].copyWith(task: newTask, isDone: isDone, updatedOn: now);
      todos.refresh(); // Perbarui tampilan
    }
  }

  // Fungsi untuk menghapus todo di Firestore
  Future<void> deleteTodo(String id) async {
    await _firestore.collection('todos').doc(id).delete();
    todos.removeWhere((element) => element.id == id);
  }
}
