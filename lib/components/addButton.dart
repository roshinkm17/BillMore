import 'package:biller/constants.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  AddButton({this.onPressed, this.buttonText});
  final Function onPressed;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: onPressed,
        child: Text(buttonText, style: TextStyle(color: Colors.white),),
        color: buttonColor,
      ),
    );
  }
}
