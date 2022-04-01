import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:testing_app/components/firebase_error_handler.dart';
import 'package:testing_app/screens/main_screen.dart';

import '../components/header.dart';
import '../components/input_wrapper.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  FocusManager focusManager = FocusManager.instance;
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  FirebaseErrorHandler errorHandler = FirebaseErrorHandler();
  final _formKey = InputWrapper.formKey;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusManager.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.lightBlue.shade700,
              Colors.lightBlue.shade300,
              Colors.lightBlue.shade400,
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 80.0,
                ),
                const Header(
                  headerText: 'Welcome back!',
                  accessoryText: 'We missed you',
                ),
                Expanded(
                  child: AnimatedOpacity(
                    opacity: animation.value,
                    duration: controller.duration!,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                      child: InputWrapper(
                        validate: false,
                        onEmailChanged: (value) {
                          email = value;
                        },
                        onPasswordChanged: (value) {
                          password = value;
                        },
                        isLoading: showSpinner,
                        buttonText: 'Log in',
                        onPressedFunction: () async {
                          if (_formKey.currentState!.validate()) {
                            await _checkInternetConnection(context);
                            setState(() {
                              showSpinner = true;
                            });
                            await _login(context);
                          }
                        },
                        buttonStyle: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.lightBlue),
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(25.0, 45.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<void> _checkInternetConnection(BuildContext context) async {
    bool result = await InternetConnectionChecker().hasConnection;
    result
        ? Alert(
            context: context,
            title: 'ERROR',
            desc: 'No internet please connect')
        : null;
  }

  Future<void> _login(BuildContext context) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        Navigator.pushNamed(context, MainScreen.id);
      }
      setState(() {
        showSpinner = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        showSpinner = false;
      });
      errorHandler.handleError(e.code, context);
    }
  }
}
