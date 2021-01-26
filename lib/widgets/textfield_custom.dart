import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;

  CustomTextField({@required this.labelText});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.labelText,
      ),
    );
  }
}
