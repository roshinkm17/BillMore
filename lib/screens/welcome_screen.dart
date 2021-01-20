import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:biller/components/mainButton.dart';
import 'package:biller/screens/registration_screen_one.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen_id";
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
  }
  void checkIfLoggedIn() async{
    var token = await Backendless.userService.getUserToken();
    if(token != null && token.isNotEmpty){
      //User already logged in
      print("User found!");
      var isValid = await Backendless.userService.isValidLogin();
      print("is valid: $isValid");
      if(isValid){
        Navigator.of(context).pushReplacementNamed(HomeScreen.id);
      }
    }
    else{
      print("No user found!");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 400,
              width: 600,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                )
              ),
            ),
            Column(
              children: [
                MainButton(
                  buttonText: "Log in",
                  onPressed: () {
                    print("Log in");
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
                SizedBox(height: 20),
                MainButton(
                  buttonText: "Sign up",
                  onPressed:(){
                    print("Sign up");
                    Navigator.pushNamed(context, RegistrationScreenOne.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
