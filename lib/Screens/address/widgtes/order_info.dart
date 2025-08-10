import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderInfoWidget extends StatelessWidget {
  final String subtotal;
  final String shippingCost;
  final String total;

  OrderInfoWidget({
    required this.subtotal,
    required this.shippingCost,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildOrderRow('Subtotal', subtotal),
            _buildOrderRow('Shipping cost', shippingCost),
            Divider(),
            _buildOrderRow('Total', total, isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}