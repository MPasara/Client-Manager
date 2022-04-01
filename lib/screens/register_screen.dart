import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/components/firebase_error_handler.dart';
import '../components/header.dart';
import '../components/input_wrapper.dart';
import 'main_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  FirebaseErrorHandler errorHandler = FirebaseErrorHandler();

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

  final _formKey = InputWrapper.formKey;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.blueAccent.shade700,
              Colors.blueAccent.shade100,
              Colors.blueAccent.shade400,
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 80.0,
                ),
                const Header(
                  headerText: 'Welcome!',
                  accessoryText: 'Please register, we want to meet you',
                ),
                Expanded(
                  child: AnimatedOpacity(
                    opacity: animation.value,
                    duration: controller.duration!,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
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
                        buttonText: 'Register',
                        onPressedFunction: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showSpinner = true;
                            });
                            await _register(context);
                          }
                        },
                        buttonStyle: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueAccent),
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

  Future<void> _register(BuildContext context) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
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
    } catch (e) {
      print(e);
    }
  }
}
