import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';

class FirebaseErrorHandler {
  void handleError(String errorCode, BuildContext context) {
    switch (errorCode) {
      case 'user-not-found':
        {
          _showAlert(context, kUserNotFoundError, kOopsAlertTitle);
        }
        break;

      case 'wrong-password':
        {
          _showAlert(context, kWrongPasswordError, kOopsAlertTitle);
        }
        break;
      case 'invalid-email':
        {
          _showAlert(context, kInvalidEmailError, kOopsAlertTitle);
        }
        break;
      case 'email-already-in-use':
        {
          _showAlert(context, kEmailAlreadyInUseError, kOopsAlertTitle);
        }
        break;
      case 'weak-password':
        {
          _showAlert(context, kWeakPasswordError, kOopsAlertTitle);
        }
        break;
    }
  }

  Future<bool?> _showAlert(
      BuildContext context, String errorMessage, String title) {
    return Alert(
      context: context,
      title: title,
      buttons: [
        DialogButton(
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120.0,
        )
      ],
      desc: errorMessage,
    ).show();
  }
}
