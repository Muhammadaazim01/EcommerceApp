import 'package:ecommerceapp/Screens/cart/cart_main.dart';
import 'package:ecommerceapp/Screens/detail_screen/widgets/card.dart'
    show DetailCard;
import 'package:ecommerceapp/Screens/home/widgets/card.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel productModel;
  const DetailScreen({super.key, required this.productModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late List<String> imageList;

  @override
  void initState() {
    super.initState();
    imageList = widget.productModel.images ?? [];
  }

  List<String> sizednumber = ["S", "M", "L", "XL", "XXL"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ✅ Top AppBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, size: 28),
                ),
                Text(
                  widget.productModel.category?.name ?? "Detail",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () => Stack(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
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
          ),

          // ✅ Product Image Carousel Overlapping
          // ✅ Product Image Carousel Overlapping – Stylish Version
          Stack(
            children: [
              Container(
                height: 280,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey.shade100, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imageList.isEmpty ? 1 : imageList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 15,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: imageList.isEmpty
                            ? Image.asset(
                                'assets/images/placeholder.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Image.network(
                                imageList[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                      ),
                    );
                  },
                ),
              ),

              // ✅ Stylish Page Indicator
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imageList.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 16 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentPage == index
                            ? Colors.black
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ✅ Stylish Detail Card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: DetailCard(
                title: widget.productModel.title ?? "No title",
                price: widget.productModel.price?.toString() ?? "No price",
                category: widget.productModel.category?.name ?? "No category",
                rating: 5.0,
                description:
                    widget.productModel.description ?? "No description",
                imageurl: imageList.isNotEmpty ? imageList[0] : '',
                productModel: widget.productModel,
                listsize: sizednumber,
                sizebuttontap: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
