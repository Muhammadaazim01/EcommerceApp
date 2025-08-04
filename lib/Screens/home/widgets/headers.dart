import 'package:flutter/material.dart';

Widget buildLatestHeader(ScrollController latestScrollController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Latest Collection",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            latestScrollController.animateTo(
              latestScrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          },
          child: const Text("Show all >", style: TextStyle(fontSize: 15)),
        ),
      ],
    ),
  );
}
