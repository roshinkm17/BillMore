import 'package:biller/components/mainButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = "welcome_screen_id";
  WelcomeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Biller",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 48,),
          ),
          Column(
            children: [
              MainButton(buttonText: "Log in"),
              SizedBox(height: 20),
              MainButton(buttonText: "Sign up",)
            ],
          ),
        ],
      ),
    );
  }
}
