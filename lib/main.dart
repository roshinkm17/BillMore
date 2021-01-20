import 'package:biller/screens/home_screen.dart';
import 'package:biller/screens/invoice_screen.dart';
import 'package:biller/screens/layout_screen.dart';
import 'package:biller/screens/login_screen.dart';
import 'package:biller/screens/registration_screen_one.dart';
import 'package:biller/screens/registration_screen_three.dart';
import 'package:biller/screens/registration_screen_two.dart';
import 'package:biller/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  initState(){
    super.initState();
    Backendless.initApp("C2FF4027-F6D2-C6BC-FF32-6C7A20EF4000", "852FC7C6-1FF6-497B-8B2F-641EA373D5E5", "C204D262-FFF2-4D3C-8606-6559BB1B1ECF");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biller',
      theme: ThemeData(
        fontFamily: 'SourceSansPro',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreenOne.id: (context) => RegistrationScreenOne(),
        RegistrationScreenTwo.id: (context) => RegistrationScreenTwo(),
        RegistrationScreenThree.id: (context) => RegistrationScreenThree(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        LayoutScreen.id: (context) => LayoutScreen(),
        InvoiceScreen.id: (context) => InvoiceScreen(),
      },
      initialRoute: WelcomeScreen.id,
    );
  }
}


