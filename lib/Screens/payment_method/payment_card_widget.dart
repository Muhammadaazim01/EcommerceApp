import 'package:ecommerceapp/Screens/payment_method/widgets/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentCardWidget extends StatefulWidget {
  final String cardType;
  final String lastDigits;

  const PaymentCardWidget({
    required this.cardType,
    required this.lastDigits,
    super.key,
  });

  @override
  State<PaymentCardWidget> createState() => _PaymentCardWidgetState();
}

class _PaymentCardWidgetState extends State<PaymentCardWidget> {
  final PaymentController paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        paymentController.makePayment();
      },

      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              // Card Image (replace with your actual asset)
              SizedBox(
                width: 60,
                height: 40,
                child: Image.asset(
                  "assets/images/visa_card.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 16),

              // Card Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cardType,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.lastDigits,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
