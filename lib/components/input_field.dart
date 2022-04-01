import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField(
      {Key? key,
      required this.emailHintText,
      required this.passwordHintText,
      required this.onEmailChanged,
      required this.onPasswordChanged,
      required this.isLoading,
      required this.formKey})
      : super(key: key);

  final String emailHintText;
  final String passwordHintText;
  final Function onEmailChanged;
  final Function onPasswordChanged;
  bool isLoading = true;

  final GlobalKey formKey;
// = GlobalKey<FormState>()
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade200)),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    onEmailChanged(value);
                  },
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: emailHintText,
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade200)),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    onPasswordChanged(value);
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: passwordHintText,
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
