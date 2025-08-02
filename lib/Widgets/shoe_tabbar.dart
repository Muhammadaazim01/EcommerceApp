import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoeTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const ShoeTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = [
      "Men Shoes",
      "Women Shoes",
      "Kids Shoes",
      "Casual",
      "Sports",
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final bool isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 200),
                style: GoogleFonts.roboto(
                  fontSize: isSelected ? 20 : 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.white70,
                ),
                child: Text(tabs[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
