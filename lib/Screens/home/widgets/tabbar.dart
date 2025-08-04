import 'package:flutter/material.dart';

class ShoeTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final List<String> tabs;

  const ShoeTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
