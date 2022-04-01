import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'input_field.dart';

class InputWrapper extends StatelessWidget {
  InputWrapper({
    Key? key,
    required this.buttonText,
    required this.onPressedFunction,
    required this.buttonStyle,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.isLoading,
    required this.validate,
  }) : super(key: key);

  final String buttonText;
  final Function onPressedFunction;
  final ButtonStyle buttonStyle;
  final Function onEmailChanged;
  final Function onPasswordChanged;
  final bool isLoading;
  final bool validate;
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputField(
            formKey: formKey,
            isLoading: isLoading,
            emailHintText: 'Enter your email',
            passwordHintText: 'Enter your password (min 6 characters)',
            onEmailChanged: onEmailChanged,
            onPasswordChanged: onPasswordChanged,
          ),
          const SizedBox(
            height: 50,
          ),
          //Button(),

          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              onPressedFunction();
            },
            child: isLoading
                ? const SpinKitFadingCircle(
                    color: Colors.white,
                    size: 39.0,
                  )
                : Text(buttonText),
          ),
        ],
      ),
    );
  }
}
