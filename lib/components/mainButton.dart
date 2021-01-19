import 'package:flutter/material.dart';
import '../constants.dart';


class MainButton extends StatelessWidget {
  MainButton({this.buttonText, this.onPressed});
  final String buttonText;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 20),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
        color: buttonColor,
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
