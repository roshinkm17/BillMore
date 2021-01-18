import 'package:biller/screens/registration_screen_one.dart';
import 'package:biller/screens/registration_screen_three.dart';
import 'package:biller/screens/registration_screen_two.dart';
import 'package:biller/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreenOne.id: (context) => RegistrationScreenOne(),
        RegistrationScreenTwo.id: (context) => RegistrationScreenTwo(),
        RegistrationScreenThree.id: (context) => RegistrationScreenThree(),
      },
      initialRoute: RegistrationScreenTwo.id,
    );
  }
}


