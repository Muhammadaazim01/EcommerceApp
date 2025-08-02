import 'package:flutter/material.dart';
import 'payment_bottom_sheet.dart'; // Make sure this file exists

class PaymentCardWidget extends StatelessWidget {
  final String cardType;
  final String lastDigits;

  const PaymentCardWidget({
    required this.cardType,
    required this.lastDigits,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          builder: (context) => const PaymentBottomSheet(),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
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
                  "assets/images/shoes_image.png",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16),

              // Card Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardType,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastDigits,
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
