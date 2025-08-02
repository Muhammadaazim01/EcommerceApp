import 'package:ecommerceapp/Screens/cart/cart_controller.dart';
import 'package:ecommerceapp/Screens/cart/cart_main.dart';
import 'package:ecommerceapp/Screens/home/card_widget.dart';
import 'package:ecommerceapp/Widgets/shoe_tabbar.dart';
import 'package:ecommerceapp/Widgets/shoecard_vertcial.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoeHomeScreen extends StatefulWidget {
  const ShoeHomeScreen({super.key});

  @override
  State<ShoeHomeScreen> createState() => _ShoeHomeScreenState();
}

class _ShoeHomeScreenState extends State<ShoeHomeScreen> {
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());

  int selectedTabIndex = 0;

  late ScrollController latestScrollController;

  @override
  void initState() {
    super.initState();
    latestScrollController = ScrollController();
  }

  @override
  void dispose() {
    latestScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff000000), Color(0xff005DFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Obx(
                        () => Stack(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartScreen(),
                                  ),
                                );
                              },
                            ),
                            if (cartController.cartItems.isNotEmpty)
                              Positioned(
                                right: 4,
                                top: 4,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${cartController.cartItems.length}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "TrendVerse",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Collection",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  ShoeTabBar(
                    selectedIndex: selectedTabIndex,
                    onTabSelected: (index) {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 220),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 388,
                      child: Obx(() {
                        if (productController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            itemCount: productController.productList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final product =
                                  productController.productList[index];
                              return ShoeCard(
                                imageWidget:
                                    (product.images != null &&
                                        product.images!.isNotEmpty &&
                                        product.images!.first.isNotEmpty)
                                    ? Image.network(
                                        product.images!.first,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return _noImageAvailableWidget();
                                            },
                                      )
                                    : _noImageAvailableWidget(),
                                title: product.title ?? "No Title",
                                subtitle:
                                    product.category?.name ?? "No Category",
                                price: product.price != null
                                    ? '\$${product.price}'
                                    : 'No Price',
                                product: product,
                              );
                            },
                          );
                        }
                      }),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Latest Collection",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              latestScrollController.animateTo(
                                latestScrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOut,
                              );
                            },

                            child: Text(
                              "Show all",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 105,
                      child: Obx(() {
                        if (productController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            controller: latestScrollController,
                            itemCount: productController.productList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final verticalproduct =
                                  productController.productList[index];
                              return ShoeCardVertcial(
                                imageurl:
                                    verticalproduct.images?.first ?? "no image",
                              );
                            },
                          );
                        }
                      }),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noImageAvailableWidget() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: Text(
        "No Image Available",
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
      ),
    );
  }
}
