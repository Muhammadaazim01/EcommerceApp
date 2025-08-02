import 'package:flutter/material.dart';

class SizedButton extends StatelessWidget {
  final String size;
  final bool isSelected;

  const SizedButton({super.key, required this.size, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      child: Center(
        child: Text(
          size,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
