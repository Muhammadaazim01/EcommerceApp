import 'package:ecommerceapp/Screens/address/address_controller.dart';
import 'package:ecommerceapp/Screens/address/widgtes/bottom_sheet.dart';
import 'package:ecommerceapp/Screens/cart/cart_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  var isLoading = false.obs;

  final AddressController addressController = Get.put(AddressController());

  void _showAddAddressSheet() {
    Get.bottomSheet(AddAddressBottomSheet(), isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Your Address",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF512F), // Bright Orange
                Color(0xFFF09819), //ght Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, // <-- yahan apna custom color do
          size: 28, // optional size change
        ),
      ),
      body: Obx(() {
        if (addressController.isLoading.value) {
          // Loading spinner during API fetch
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              strokeWidth: 2,
            ),
          );
        }

        if (addressController.addressList.isEmpty) {
          // Agar address list khali ho
          return Center(
            child: Text(
              "No Addresses Added Yet",
              style: GoogleFonts.montserrat(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: addressController.addressList.length,
          itemBuilder: (context, index) {
            final addr = addressController.addressList[index];
            final isSelected =
                addressController.selectedAddress.value?.id == addr.id;

            return GestureDetector(
              onTap: () async {
                addressController.isLoading.value = true;
                addressController.selectedAddress.value = addr;
                addressController.selectedAddress.refresh();
                await Future.delayed(Duration(seconds: 1));
                addressController.isLoading.value = false;
                Get.to(() => CartScreen());
              },
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey.shade200,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on, color: Colors.red, size: 26),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                addr.name ?? "",
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                addr.description ?? "",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (isSelected)
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      }),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddAddressSheet,
        backgroundColor: Color(0xFFFF512F),
        icon: Icon(Icons.add, color: Colors.black),
        label: Text("Add", style: GoogleFonts.montserrat(color: Colors.black)),
      ),
    );
  }
}
