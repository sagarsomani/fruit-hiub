import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.title,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
  });

  final String? title;
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final textField = Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xFFF3F1F1),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => value == null || value.isEmpty
            ? 'Please enter a valid input'
            : null,
      ),
      
    );

    if (title == null) {
      return textField;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 22),
        ),
        const SizedBox(height: 20),
        textField,
      ],
    );
  }
}
