import 'package:flutter/material.dart';
import '../constants.dart';

class AddClientTextField extends StatelessWidget {
  const AddClientTextField(
      {Key? key,
      required this.hintText,
      required this.validatorErrorText,
      required this.textInputType,
      required this.controller})
      : super(key: key);

  final String hintText;
  final String validatorErrorText;
  final TextInputType textInputType;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: TextFormField(
          autofocus: true,
          maxLines: null,
          controller: controller,
          keyboardType: textInputType,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorErrorText;
            }
            return null;
          },
          decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderSide: kBorderSideRed,
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: kBorderSideRed,
              borderRadius: BorderRadius.circular(35.0),
            ),
            hintText: hintText,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelStyle: kFloatingLabelStyle,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: kBorderSideBlue,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: kBorderSideGray,
            ),
          )),
    );
  }
}
