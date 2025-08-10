import 'package:ecommerceapp/Screens/payment_method/widgets/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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

class _PaymentCardWidgetState extends State<PaymentCardWidget>
    with SingleTickerProviderStateMixin {
  final PaymentController paymentController = Get.find();

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Listen for payment success changes
    ever(paymentController.paymentSuccess, (success) {
      if (success == true) {
        _animationController.forward().then(
          (value) => _animationController.reverse(),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool success = paymentController.paymentSuccess.value;

      return GestureDetector(
        onTap: () {
          if (!paymentController.isLoading.value) {
            paymentController.makePayment();
          }
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Card(
            elevation: success ? 8 : 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: success ? Colors.green.shade100 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: success ? Colors.green.shade200 : Colors.black12,
                    blurRadius: success ? 10 : 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 40,
                        child: Image.asset(
                          "assets/images/visa_card.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      if (success)
                        Icon(
                          Icons.check_circle,
                          color: Color(0xFFFF512F),
                          size: 40,
                        ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cardType,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: success ? Colors.black : Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.lastDigits,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: success ? Colors.black : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
