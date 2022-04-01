import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/screens/welcome_screen.dart';

import '../components/firebase_error_handler.dart';
import '../constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusManager focusManager = FocusManager.instance;
  late String newPassword;
  final passwordController = TextEditingController();
  FirebaseErrorHandler errorHandler = FirebaseErrorHandler();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  bool _formValid = true;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusManager.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: kSignOutIcon,
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, WelcomeScreen.id, (r) => false);
                },
              )
            ],
            automaticallyImplyLeading: false,
            shape: kAppBarShape,
            backgroundColor: Colors.blue,
            title: const Center(child: Text('Settings')),
          ),
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    autofocus: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide: kBorderSideRed,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: kBorderSideRed,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: "Enter new password",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: kBorderSideBlue,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: kBorderSideGray,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _formValid = false;
                        return 'Password field cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _checkFormValidity(context);
                    _updatePassword(context, _formValid);
                  },
                  child: const Text('Update password'),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(25.0, 45.0),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _checkFormValidity(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form is not valid')),
      );
    }
    if (passwordController.text.length < 6) {
      _formValid = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password is too weak')),
      );
    }
  }

  void _updatePassword(BuildContext context, _formValid) {
    if (_formValid) {
      newPassword = passwordController.text;
      try {
        loggedInUser.updatePassword(newPassword);
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password updated, log in again.')),
          );
          passwordController.text = '';
          _auth.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, WelcomeScreen.id, (r) => false);
        }
      } on FirebaseAuthException catch (e) {
        errorHandler.handleError(e.code, context);
      }
    }
  }
}
