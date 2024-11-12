import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Rx variables for handling loading state and error messages
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Method to register with email and password
  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Firebase authentication call
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      
      // Navigate to the next page or show success message
      Get.snackbar("Success", "Account created successfully!");
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? "Unknown error occurred";
    } finally {
      isLoading.value = false;
    }
  }
}
