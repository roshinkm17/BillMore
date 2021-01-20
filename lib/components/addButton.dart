import 'package:biller/constants.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  AddButton({this.onPressed, this.buttonText});
  final Function onPressed;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 30,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
        color: buttonColor,
      ),
    );
  }
}
