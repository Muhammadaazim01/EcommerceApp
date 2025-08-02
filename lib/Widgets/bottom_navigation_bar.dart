import 'package:ecommerceapp/Screens/favrouite/controller.dart';
import 'package:ecommerceapp/Screens/favrouite/favorite_screen.dart';
import 'package:ecommerceapp/Screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBarScreen extends StatefulWidget {
  final int initialIndex;
  const BottomNavBarScreen({super.key, required this.initialIndex});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ShoeHomeScreen(),
    Center(child: Text("Search")),
    FavoriteScreen(),
    Center(child: Text("Profile")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Obx(() {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      const Icon(Icons.favorite_border),
                      if (favoriteController.favoriteItems.isNotEmpty)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${favoriteController.favoriteItems.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
