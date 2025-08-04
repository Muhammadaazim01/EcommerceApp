import 'package:flutter/material.dart';

class ShoeCardVertcial extends StatelessWidget {
  final Widget imageWidget;

  const ShoeCardVertcial({
    Key? key,
    required this.imageWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 105,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: imageWidget,
      ),
    );
  }
}
