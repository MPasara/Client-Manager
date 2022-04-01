import 'package:flutter/material.dart';

class UpdateClientTextField extends StatelessWidget {
  const UpdateClientTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
      keyboardType: keyboardType,
    );
  }
}
