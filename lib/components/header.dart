import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String headerText;
  final String accessoryText;
  const Header(
      {Key? key, required this.headerText, required this.accessoryText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              headerText,
              style: const TextStyle(color: Colors.white, fontSize: 40.0),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              accessoryText,
              style: const TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
