import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/app/modules/page/home/controllers/home_controller.dart'; // Import your new page
import 'package:tes/app/routes/app_pages.dart'; // Import your new page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  int _selectedIndex = 0;

  // List of widgets to display for each tab
  final List<Widget> _pages = [
    Center(child: Text('Home Page Content')),
    Center(child: Text('History Page Content')),
    Center(child: Text('Account Page Content')),
  ];

  void _onItemTapped(int index) {
    if (index == 2) { // Index 2 for Account tab
      Get.toNamed(Routes.PROFILE); // Navigasi menggunakan rute bernama
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
