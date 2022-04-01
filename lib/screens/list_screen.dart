import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:testing_app/screens/welcome_screen.dart';

import '../constants.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final _firestore = FirebaseFirestore.instance;

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
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
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(22),
            ),
          ),
          title: const Center(
            child: Text('Clients'),
          ),
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('clients')
              .where('userId', isEqualTo: loggedInUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: SpinKitFadingCircle(
                color: Colors.lightBlueAccent,
              ));
            } else {
              return ListView(
                children: snapshot.data!.docs.map((doc) {
                  return Card(
                    child: Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(
                          () => _firestore
                              .collection('clients')
                              .doc(doc.id)
                              .delete()
                              .then(
                                (value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Client deleted'),
                                  ),
                                ),
                              ),
                        );
                      },
                      child: ListTile(
                        style: ListTileStyle.drawer,
                        onTap: () {
                          _showAlert(
                              context,
                              'Age: ' +
                                  doc['age'].toString() +
                                  '\n' +
                                  'Height: ' +
                                  doc['height'].toString() +
                                  '\n' +
                                  'Weight: ' +
                                  doc['weight'].toString() +
                                  '\n' +
                                  'Lower arm: ' +
                                  doc['lower arm'].toString() +
                                  '\n' +
                                  'Upper arm: ' +
                                  doc['upper arm'].toString() +
                                  '\n' +
                                  'Waist: ' +
                                  doc['waist'].toString() +
                                  '\n' +
                                  'Lower leg: ' +
                                  doc['lower leg'].toString() +
                                  '\n' +
                                  'Upper leg: ' +
                                  doc['upper leg'].toString() +
                                  '\n' +
                                  'Chest: ' +
                                  doc['chest'].toString() +
                                  '\n' +
                                  'Gender: ' +
                                  doc['gender'].toString() +
                                  '\n' +
                                  'Notes: ' +
                                  doc['notes'].toString(),
                              doc['name'] + ' ' + doc['surname']);
                        },
                        leading:
                            doc['gender'] == 'Male' ? kMaleIcon : kFemaleIcon,
                        title: Text(
                          doc['name'] + ' ' + doc['surname'],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ));
  }
}

Future<bool?> _showAlert(
    BuildContext context, String clientDetails, String title) {
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
    desc: clientDetails,
  ).show();
}
