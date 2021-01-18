import 'package:biller/components/CustomInputField.dart';
import 'package:biller/components/mainButton.dart';
import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}): super(key: key);
  static String id = "login_screen_id";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<int> userLogin(email, password) async{
    try{
      var res = await Backendless.userService.login(email, password, true);
      return 1;
    }catch(e){
      return 0;
    }
  }
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: ListView(
              children: [
                Text(
                  "Log in",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 40),
                CustomInputField(
                  placeholder: "Email",
                  onChanged: (value){
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Password",
                  ),
                  onChanged: (value){
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                MainButton(
                  buttonText: "Log in",
                  onPressed: ()async {
                    // Navigator.pushNamed(context, routeName);
                    int res = await userLogin(email, password);
                    if(res == 1){
                      Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                    }
                    else{
                      final snackBar = SnackBar(
                        content: Text('Invalid Username/ Password'),
                        duration: Duration(seconds: 2),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                    print("Log in");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
