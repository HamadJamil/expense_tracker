import 'package:flutter/material.dart';

class CutsomTextformField extends StatelessWidget {
  const CutsomTextformField({
    super.key,
    required this.label,
    required this.hintText,
    required this.validateMsg,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLength,
  });
  final String label;
  final String hintText;
  final String validateMsg;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validateMsg;
        }
        return null;
      },
    );
  }
}
