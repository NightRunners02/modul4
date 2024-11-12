import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/app/routes/app_pages.dart'; // Import your new page


class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Entity Coffe'),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.REGISTER),
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
