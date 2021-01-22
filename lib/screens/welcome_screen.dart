import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:biller/components/mainButton.dart';
import 'package:biller/screens/registration_screen_one.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
    setState(() {
      _isSaving = true;
    });
    var token = await Backendless.userService.getUserToken();
    if(token != null && token.isNotEmpty){
      //User already logged in
      print("User found!");
      try{
        var isValid = await Backendless.userService.isValidLogin();
        String currentUserObjectId = await Backendless.userService.loggedInUser();
        var user = await Backendless.data.of("Users").findById(currentUserObjectId);
        print("is valid: $isValid");
        print("user : $user");
        if(isValid){
          setState(() {
            _isSaving = false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(currentUseremail: user['email'],)));
        }
      }catch(e){
        print(e);
      }
    }
    else{
      print("No user found!");
    }
    setState(() {
      _isSaving = false;
    });
  }
  bool _isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: _isSaving,
        progressIndicator: CircularProgressIndicator(
          strokeWidth: 5,
        ),
        child: Padding(
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
      ),
    );
  }
}
