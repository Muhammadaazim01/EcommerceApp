import 'package:ecommerceapp/Screens/address/address_controller.dart';
import 'package:ecommerceapp/Screens/address/address_model.dart';
import 'package:ecommerceapp/Screens/address/widgtes/textfield.dart';
import 'package:ecommerceapp/Screens/cart/cart_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddressBottomSheet extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final AddressController addressController = Get.find<AddressController>();

  AddAddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF512F), // Bright Orange
            Color(0xFFF09819), //ght Blu
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5,
              width: 50,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Text(
              "Add New Address",
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            buildTextField(nameController, "Name", Icons.person),
            buildTextField(descController, "Description", Icons.location_on),

            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF512F),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    descController.text.isNotEmpty) {
                  final newAddress = AddressModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: nameController.text,
                    description: descController.text,
                  );

                  addressController.addAddress(newAddress);

                  // Select the newly added address
                  addressController.selectedAddress.value = newAddress;

                  // Close bottom sheet
                  Get.back();

                  // Navigate to CartScreen (assuming you have it imported)
                  Get.to(() => CartScreen());
                } else {
                  Get.snackbar(
                    "Error",
                    "Please fill all fields",
                    backgroundColor: Colors.grey[800],
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.all(12),
                    borderRadius: 8,
                    duration: Duration(seconds: 2),
                  );
                }
              },

              child: Text(
                "Save Address",
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
