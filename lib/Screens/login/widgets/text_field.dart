import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData prefixIcon;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: labelText,

        filled: true,
        fillColor: Colors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),

        prefixIcon: Icon(prefixIcon, color: Colors.black),
      ),
    );
  }
}
