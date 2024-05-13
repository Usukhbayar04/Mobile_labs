// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final BorderRadius borderRadius;
  final FormFieldValidator<String>? validator;

  CustomTextField({
    super.key,
    required this.labelText,
    this.borderRadius = BorderRadius.zero,
    this.validator,
    required Function(dynamic value) onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: borderRadius, // Set the borderRadius property here
        ),
      ),
      validator: validator,
    );
  }
}
