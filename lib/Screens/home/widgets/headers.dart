import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildLatestHeader(ScrollController latestScrollController) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Latest Collection",
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            latestScrollController.animateTo(
              latestScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          },
          child: Text(
            "Show all >",
            style: GoogleFonts.montserrat(fontSize: 15, color: Colors.black54),
          ),
        ),
      ],
    ),
  );
}
