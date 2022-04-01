import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/update_client_text_field.dart';

class UpdateClientBottomSheet extends StatefulWidget {
  const UpdateClientBottomSheet({Key? key, required this.doc})
      : super(key: key);

  final QueryDocumentSnapshot doc;

  @override
  State<UpdateClientBottomSheet> createState() =>
      _UpdateClientBottomSheetState();
}

class _UpdateClientBottomSheetState extends State<UpdateClientBottomSheet> {
  FocusManager focusManager = FocusManager.instance;

  final _nameController = TextEditingController();

  final _surnameController = TextEditingController();

  final _ageController = TextEditingController();

  final _heightController = TextEditingController();

  final _weightController = TextEditingController();

  final _lowerArmController = TextEditingController();

  final _upperArmController = TextEditingController();

  final _waistController = TextEditingController();

  final _lowerLegController = TextEditingController();

  final _upperLegController = TextEditingController();

  final _chestController = TextEditingController();

  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Male';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.doc['name'];
    _surnameController.text = widget.doc['surname'];
    _ageController.text = widget.doc['age'].toString();
    _heightController.text = widget.doc['height'].toString();
    _weightController.text = widget.doc['weight'].toString();
    _lowerArmController.text = widget.doc['lower arm'].toString();
    _upperArmController.text = widget.doc['upper arm'].toString();
    _waistController.text = widget.doc['waist'].toString();
    _lowerLegController.text = widget.doc['lower leg'].toString();
    _upperLegController.text = widget.doc['upper leg'].toString();
    _chestController.text = widget.doc['chest'].toString();
    //String dropdownValue = widget.doc['gender'].toString();
    List<String> dropDownItems = ['Male', 'Female'];
    _notesController.text = widget.doc['notes'].toString();

    return GestureDetector(
      onTap: () => focusManager.primaryFocus?.unfocus(),
      child: Container(
        padding: const EdgeInsets.all(30.0),
        height: MediaQuery.of(context).size.height * 0.877,
        decoration: kModalBoxDecoration,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                UpdateClientTextField(
                    controller: _nameController,
                    keyboardType: TextInputType.text),
                const Text(
                  'First name',
                ),
                UpdateClientTextField(
                    controller: _surnameController,
                    keyboardType: TextInputType.text),
                const Text(
                  'Surname',
                ),
                UpdateClientTextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                ),
                const Text(
                  'Age',
                ),
                UpdateClientTextField(
                    controller: _heightController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
                const Text(
                  'Height',
                ),
                UpdateClientTextField(
                    controller: _weightController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
                const Text(
                  'Weight',
                ),
                UpdateClientTextField(
                    controller: _lowerArmController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
                const Text(
                  'Lower arm',
                ),
                UpdateClientTextField(
                    controller: _upperArmController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
                const Text(
                  'Upper arm',
                ),
                UpdateClientTextField(
                    controller: _waistController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
                const Text(
                  'Waist',
                ),
                UpdateClientTextField(
                    controller: _lowerLegController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
                const Text(
                  'Lower leg',
                ),
                UpdateClientTextField(
                    controller: _upperLegController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
                const Text(
                  'Upper leg',
                ),
                UpdateClientTextField(
                    controller: _chestController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false)),
                const Text(
                  'Chest',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Gender',
                    ),
                    const SizedBox(width: 20.0),
                    DropdownButton(
                      value: dropdownValue,
                      icon:
                          const Icon(Icons.arrow_downward, color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: dropdownValue == 'Male'
                            ? Colors.blue
                            : Colors.pinkAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() => dropdownValue = newValue!);

                        //print('new gender ' + newValue!);
                      },
                      items: dropDownItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                UpdateClientTextField(
                    controller: _notesController,
                    keyboardType: TextInputType.text),
                const Text(
                  'Notes',
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateClient(dropdownValue, context);
                      }
                    },
                    child: const Text('Update client'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateClient(String dropdownValue, BuildContext context) {
    widget.doc.reference
        .update({
          'name': _nameController.text,
          'surname': _surnameController.text,
          'age': _ageController.text,
          'height': _heightController.text,
          'weight': _weightController.text,
          'lower arm': _lowerArmController.text,
          'upper arm': _upperArmController.text,
          'waist': _waistController.text,
          'lower leg': _lowerLegController.text,
          'upper leg': _upperLegController.text,
          'chest': _chestController.text,
          'gender': dropdownValue,
          'notes': _notesController.text
        })
        .then((value) => Navigator.pop(context))
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.blue,
              content: Text('Client updated'),
            ),
          ),
        )
        .catchError((error) => print('Update failed: $error'));
  }
}
