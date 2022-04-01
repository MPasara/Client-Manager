import 'package:flutter/material.dart';

const kTitleTextStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
);

const kAppBarShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    bottom: Radius.circular(22),
  ),
);

const kSignOutIcon = Icon(
  Icons.logout,
  color: Colors.white,
);

const kOopsAlertTitle = 'OOPS';
const kUserNotFoundError = 'No user found for that email.';
const kWrongPasswordError = 'Wrong password provided for that user.';
const kInvalidEmailError = 'Email address is not formed well.';
const kEmailAlreadyInUseError = 'Account already exists with that email';
const kWeakPasswordError = 'The password provided is too weak.';

const kFloatingLabelStyle = TextStyle(color: Colors.black);
const kBorderSideBlack = BorderSide(color: Colors.black, width: 2.0);
const kBorderSideBlue = BorderSide(color: Colors.blue, width: 2.0);
const kBorderSideRed = BorderSide(color: Colors.red);
const kBorderSideGray = BorderSide(
  color: Colors.grey,
  width: 2.0,
);

const kModalBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(25.0),
    topRight: Radius.circular(25.0),
  ),
);

const kMaleIcon = Icon(Icons.man, color: Colors.blue);
const kFemaleIcon = Icon(Icons.woman, color: Colors.pinkAccent);
