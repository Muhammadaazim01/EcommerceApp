import 'package:flutter/material.dart';

class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Enter Card Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildInputField(label: 'Card Number', icon: Icons.credit_card),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  label: 'Expiry MM/YY',
                  icon: Icons.date_range,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInputField(label: 'CVC', icon: Icons.lock_outline),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Payment processing...")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 5,
              ),
              child: const Text(
                "Pay Now",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({required String label, required IconData icon}) {
    return TextField(
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: Icon(icon, color: Colors.black54),
        labelStyle: const TextStyle(color: Colors.black54),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        fillColor: Colors.grey[100],
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
