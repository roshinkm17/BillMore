import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({this.placeholder, this.onChanged});
  final String placeholder;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: placeholder,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
