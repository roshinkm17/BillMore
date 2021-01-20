import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({this.placeholder, this.onChanged, this.keyboardType, this.controller});
  final String placeholder;
  final Function onChanged;
  final TextEditingController controller;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
    keyboardType: keyboardType == null ? TextInputType.text : keyboardType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
