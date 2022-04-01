import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/models/client.dart';
import 'package:testing_app/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';
import '../widgets/add_client_text_field.dart';

class AddScreen extends StatefulWidget {
  static const String id = 'add_screen';

  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final _formKey = GlobalKey<FormState>();
  FocusManager focusManager = FocusManager.instance;
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final lowerArmController = TextEditingController();
  final upperArmController = TextEditingController();
  final waistController = TextEditingController();
  final lowerLegController = TextEditingController();
  final upperLegController = TextEditingController();
  final chestController = TextEditingController();
  final notesController = TextEditingController();

  List<String> dropDownItems = ['Male', 'Female'];

  late Client client;
  late String? newValue;
  String dropdownValue = 'Male';

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
            title: const Center(child: Text('Add')),
          ),
          backgroundColor: Colors.white,
          body: RawScrollbar(
            thumbColor: Colors.blue.shade300,
            thickness: 5.0,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AddClientTextField(
                      hintText: 'Enter clients first name',
                      validatorErrorText: 'Name field cannot be empty',
                      textInputType: TextInputType.text,
                      controller: nameController,
                    ),
                    AddClientTextField(
                      hintText: 'Enter clients surname',
                      validatorErrorText: 'Surname field cannot be empty',
                      textInputType: TextInputType.text,
                      controller: surnameController,
                    ),
                    AddClientTextField(
                      hintText: 'Enter clients age',
                      validatorErrorText: 'Age field cannot be empty',
                      textInputType: TextInputType.number,
                      controller: ageController,
                    ),
                    AddClientTextField(
                      hintText: 'Enter clients height',
                      validatorErrorText: 'Height field cannot be empty',
                      textInputType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      controller: heightController,
                    ),
                    AddClientTextField(
                      hintText: 'Enter clients weight',
                      validatorErrorText: 'Weight field cannot be empty',
                      textInputType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      controller: weightController,
                    ),
                    AddClientTextField(
                      hintText: 'Enter clients lower arm circumference',
                      validatorErrorText: 'Lower arm field cannot be empty',
                      textInputType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      controller: lowerArmController,
                    ),
                    AddClientTextField(
                      hintText: 'Enter clients upper arm circumference',
                      validatorErrorText: 'Upper arm field cannot be empty',
                      textInputType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      controller: upperArmController,
                    ),
                    AddClientTextField(
                      hintText: 'Enter clients waist circumference',
                      validatorErrorText: 'Waist field cannot be empty',
                      textInputType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      controller: waistController,
                    ),
                    AddClientTextField(
                      hintText: 'Enter clients lower leg circumference',
                      validatorErrorText: 'Lower leg field cannot be empty',
                      textInputType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      controller: lowerLegController,
                    ),
                    AddClientTextField(
                      hintText: 'Enter clients upper leg circumference',
                      validatorErrorText: 'Upper leg field cannot be empty',
                      textInputType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      controller: upperLegController,
                    ),
                    AddClientTextField(
                      hintText: 'Enter clients chest circumference',
                      validatorErrorText: 'Chest field cannot be empty',
                      textInputType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      controller: chestController,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2.0,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'GENDER:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            DropdownButton(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward,
                                  color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: dropdownValue == 'Male'
                                    ? Colors.blue
                                    : Colors.pinkAccent,
                              ),
                              onChanged: (String? newValue) {
                                setState(() => dropdownValue = newValue!);
                              },
                              items: dropDownItems
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    ),
                    AddClientTextField(
                      hintText: 'Enter your notes here',
                      validatorErrorText: 'If no notes enter /',
                      textInputType: TextInputType.multiline,
                      controller: notesController,
                    ),
                    ElevatedButton(
                      onPressed: () => _addClient(context),
                      child: const Text('Add client'),
                    ),
                    const SizedBox(
                      height: 22.0,
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void _addClient(BuildContext context) {
    if (_checkFormValidity(context)) {
      client = Client(
          nameController.text,
          surnameController.text,
          int.parse(ageController.text),
          double.parse(heightController.text),
          double.parse(weightController.text),
          double.parse(lowerArmController.text),
          double.parse(upperArmController.text),
          double.parse(waistController.text),
          double.parse(lowerLegController.text),
          double.parse(upperLegController.text),
          double.parse(chestController.text),
          dropdownValue,
          notesController.text);
      _firestore.collection('clients').add({
        'userId': loggedInUser.uid,
        'name': client.firstname,
        'surname': client.surname,
        'age': client.age,
        'height': client.height,
        'weight': client.weight,
        'lower arm': client.lowerArmCircumference,
        'upper arm': client.upperArmCircumference,
        'waist': client.waistCircumference,
        'lower leg': client.lowerLegCircumference,
        'upper leg': client.upperLegCircumference,
        'chest': client.chestCircumference,
        'gender': client.gender,
        'notes': client.trainerNotes
      });
      _clearForm();
    }
  }

  void _clearForm() {
    focusManager.primaryFocus?.unfocus();
    nameController.clear();
    surnameController.clear();
    ageController.clear();
    heightController.clear();
    weightController.clear();
    lowerArmController.clear();
    upperArmController.clear();
    waistController.clear();
    lowerLegController.clear();
    upperLegController.clear();
    chestController.clear();
    notesController.clear();
  }

  bool _checkFormValidity(BuildContext context) {
    bool _formValid = true;
    if (!_formKey.currentState!.validate()) {
      _formValid = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form is not valid')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('Client added successfully!')),
      );
    }
    return _formValid;
  }
}
