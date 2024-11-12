import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/auth_controller.dart'; // Import your new page

class RegisterPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Obx(() => authController.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      authController.registerUser(
                          emailController.text.trim(), passwordController.text.trim());
                    },
                    child: Text('Register'),
                  )),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.toNamed('/login'); // Navigate to LoginPage when pressed
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
