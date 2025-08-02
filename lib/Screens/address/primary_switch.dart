import 'package:flutter/material.dart';

class PrimarySwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Save as primary address'),
        Spacer(),
        Switch(value: true, onChanged: (value) {}, activeColor: Colors.green),
      ],
    );
  }
}
