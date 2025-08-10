import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildProductImage(String url, {double? width, double? height}) {
  if (url.toLowerCase().endsWith('.svg')) {
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholderBuilder: (_) =>  Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.black,
          strokeWidth: 2,
        ),
      ),
    );
  }

  return Image.network(
    url,
    width: width,
    height: height,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) => noImageAvailableWidget(width, height),
  );
}

// ✅ Public widget now
Widget noImageAvailableWidget(double? width, double? height) {
  return Container(
    width: width,
    height: height,
    color: Colors.grey[300],
    alignment: Alignment.center,
    child:  Text(
      "No Image\nAvailable",
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(color: Colors.black54, fontWeight: FontWeight.bold),
    ),
  );
}
