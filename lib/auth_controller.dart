import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/app/modules/page/login/views/login_view.dart'; // Import your new page

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  // Function to register a new user
  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar(
        'Success',
        'Registration successful',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.off(() => LoginPage()); // Navigate to LoginPage after successful registration
    } catch (error) {
      Get.snackbar(
        'Error',
        'Registration failed: $error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Function to log in an existing user
  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar(
        'Success',
        'Login successful',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed('/home'); // Navigate to home page after successful login
    } catch (error) {
      Get.snackbar(
        'Error',
        'Login failed: $error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Function to log out the user
  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/login'); // Navigate to login page after logout
    } catch (error) {
      Get.snackbar(
        'Error',
        'Logout failed: $error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
