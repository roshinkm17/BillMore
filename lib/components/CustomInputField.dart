import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({this.placeholder, this.onChanged, this.keyboardType});
  final String placeholder;
  final Function onChanged;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
    keyboardType: keyboardType == null ? TextInputType.text : keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: placeholder,
        ),
        validator: (value){
          if(value.isEmpty){
            return "Cannot be empty";
          }
          return null;
        },
        onChanged: onChanged,
      ),
    );
  }
}
