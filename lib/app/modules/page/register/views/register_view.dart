import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/app/modules/page/register/controllers/register_controller.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());
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
            // Input Field for Email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
            SizedBox(height: 10),

            // Input Field for Password
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            // Register Button
            Obx(() => registerController.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      String email = emailController.text.trim();
                      String password = passwordController.text.trim();

                      // Validate Email and Password
                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar("Error", "Email and password cannot be empty.");
                        return;
                      }

                      if (!GetUtils.isEmail(email)) {
                        Get.snackbar("Error", "Please enter a valid email address.");
                        return;
                      }

                      if (password.length < 6) {
                        Get.snackbar("Error", "Password must be at least 6 characters long.");
                        return;
                      }

                      // Save data locally using RegisterController
                      registerController.saveRegisterLocally(email, password);

                      // Provide feedback to the user
                      Get.snackbar("Success", "Data saved locally.");

                      // Clear input fields after saving
                      emailController.clear();
                      passwordController.clear();
                    },
                    child: Text('Register'),
                  )),
            SizedBox(height: 20),

            // Navigate to Login Page
            TextButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}