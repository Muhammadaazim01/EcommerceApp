import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SizedButton extends StatelessWidget {
  final String size;
  final bool isSelected;
  final VoidCallback? onTap;

  const SizedButton({
    super.key,
    required this.size,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: 60,
        width: 60,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [Colors.black, Colors.grey[800]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.grey,
          border: Border.all(color: Colors.grey, width: 3),
          borderRadius: BorderRadius.circular(14),

          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 4),
                blurRadius: 6,
              ),
          ],
        ),
        child: Center(
          child: Text(
            size,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black87,
              //  letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
