import 'package:ecommerceapp/Screens/favrouite/controller.dart';
import 'package:ecommerceapp/Screens/favrouite/favorite_screen.dart';
import 'package:ecommerceapp/Screens/home/home_screen.dart';
import 'package:ecommerceapp/Screens/search/search_screen.dart';
import 'package:ecommerceapp/controllers/category_controller.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBarScreen extends StatefulWidget {
  final int initialIndex;
  BottomNavBarScreen({super.key, required this.initialIndex});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ShoeHomeScreen(),
    SearchScreen(
      categoryController: Get.find<CategoryController>(),
      productController: Get.find<ProductController>(),
    ),
    FavoriteScreen(),
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
    // Drawer hatane ke baad app bar bhi simple kar sakte hain
    return Scaffold(
      body: _screens[_selectedIndex],

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      Icon(Icons.favorite_border),
                      if (favoriteController.favoriteItems.isNotEmpty)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${favoriteController.favoriteItems.length}',
                              style: GoogleFonts.montserrat(
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
              ],
            );
          }),
        ),
      ),
    );
  }
}
