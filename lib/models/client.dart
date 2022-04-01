class Client {
  String _firstname;
  String _surname;
  int _age;
  double height;
  double weight;
  double lowerArmCircumference;
  double upperArmCircumference;
  double waistCircumference;
  double lowerLegCircumference;
  double upperLegCircumference;
  double chestCircumference;
  String gender;
  String trainerNotes;

  Client(
      this._firstname,
      this._surname,
      this._age,
      this.height,
      this.weight,
      this.lowerArmCircumference,
      this.upperArmCircumference,
      this.waistCircumference,
      this.lowerLegCircumference,
      this.upperLegCircumference,
      this.chestCircumference,
      this.gender,
      this.trainerNotes);

  @override
  String toString() {
    return 'Client{firstname: $_firstname, surname: $_surname, age: $_age}';
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  String get surname => _surname;

  set surname(String value) {
    _surname = value;
  }

  String get firstname => _firstname;

  set firstname(String value) {
    _firstname = value;
  }
}
