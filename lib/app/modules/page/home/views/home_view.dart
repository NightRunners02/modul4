import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/app/modules/page/home/controllers/home_controller.dart';
import 'package:tes/app/routes/app_pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CoffeeShopHomePage(),
    Center(child: Text('History Page Content')),
    Center(child: Text('Account Page Content')),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      Get.toNamed(Routes.PROFILE);
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
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            Row(
              children: [
                Text('Bilzen, Tanjungbalai',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.tune, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
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

class CoffeeShopHomePage extends StatelessWidget {
  final List<Map<String, String>> menuItems = [
    {
      'image': 'https://bigcupofcoffee.com/wp-content/uploads/2023/05/cafe-mocha-1024x512.jpg',
      'name': 'Caffe Mocha',
      'price': '\$4.53',
      'description': 'Deep Foam',
    },
    {
      'image': 'https://drishop.co.id/wp-content/uploads/2024/02/kopi-espresso.jpg',
      'name': 'Espresso',
      'price': '\$3.50',
      'description': 'Rich & Bold',
    },
    {
      'image': 'https://coffeecopycat.com/wp-content/uploads/2024/01/CaramelLatte-1200x1200-1.jpg',
      'name': 'Caramel Latte',
      'price': '\$4.99',
      'description': 'Sweet & Creamy',
    },
    {
      'image': 'https://www.pinterpolitik.com/wp-content/uploads/2023/09/50de339f-7e20-4738-b9a4-a2ba49991add.webp',
      'name': 'Cappuccino',
      'price': '\$4.50',
      'description': 'Frothy & Smooth',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promotion Banner
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://via.placeholder.com/300x150'), // Placeholder Image
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Promo',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      'Buy one get one FREE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterChip(
                  label: Text('All Coffee'),
                  onSelected: (selected) {},
                  selected: true,
                  selectedColor: Colors.teal.withOpacity(0.2),
                  backgroundColor: Colors.grey.withOpacity(0.2),
                ),
                FilterChip(
                  label: Text('Macchiato'),
                  onSelected: (selected) {},
                  backgroundColor: Colors.grey.withOpacity(0.2),
                ),
                FilterChip(
                  label: Text('Latte'),
                  onSelected: (selected) {},
                  backgroundColor: Colors.grey.withOpacity(0.2),
                ),
                FilterChip(
                  label: Text('Americano'),
                  onSelected: (selected) {},
                  backgroundColor: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
          ),

          // Coffee Menu
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return CoffeeMenuItem(
                  image: item['image']!,
                  name: item['name']!,
                  price: item['price']!,
                  description: item['description']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CoffeeMenuItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String description;

  const CoffeeMenuItem({
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
