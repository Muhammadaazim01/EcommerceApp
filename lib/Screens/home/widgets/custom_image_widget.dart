import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildProductImage(String url, {double? width, double? height}) {
  if (url.toLowerCase().endsWith('.svg')) {
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholderBuilder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  return Image.network(
    url,
    width: width,
    height: height,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) => _noImageAvailableWidget(width, height),
  );
}

Widget _noImageAvailableWidget(double? width, double? height) {
  return Container(
    width: width,
    height: height,
    color: Colors.grey[300],
    alignment: Alignment.center,
    child: const Text(
      "No Image\nAvailable",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
