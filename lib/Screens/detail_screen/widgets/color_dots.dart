import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key});

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  int selectedIndex = 0;
  int? deletedIndex; // Index of deleted/dimmed dot

  final List<Color> colors = [Colors.grey, Colors.black, Colors.blue];

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(colors.length, (index) {
          bool isSelected = selectedIndex == index;
          bool isDeleted = deletedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                deletedIndex = null;
              });
            },
            onLongPress: () {
              setState(() {
                deletedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: isSelected ? 28 : 20,
              height: isSelected ? 28 : 20,
              decoration: BoxDecoration(
                color: colors[index].withOpacity(isDeleted ? 0.3 : 1),
                shape: BoxShape.circle,
                // border: isSelected ? Border.all(color: Colors.black) : null,
                boxShadow: isDeleted
                    ? [BoxShadow(color: Colors.black12, blurRadius: 4)]
                    : [],
              ),
            ),
          );
        }),
      ),
    );
  }
}
