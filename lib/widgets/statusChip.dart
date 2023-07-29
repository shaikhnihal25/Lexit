import 'package:flutter/material.dart';

class AvailabilityChip extends StatelessWidget {
  final bool isAvailable;

  AvailabilityChip({required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        isAvailable ? 'Available Now' : 'Not Available',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: isAvailable ? Colors.green : Colors.red,
    );
  }
}
