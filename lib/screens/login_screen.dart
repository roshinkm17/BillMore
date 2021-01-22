import 'package:biller/components/CustomInputField.dart';
import 'package:biller/components/mainButton.dart';
import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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
  bool _isSaving = false;
  bool _isVisible = false;
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isSaving,
        progressIndicator: CircularProgressIndicator(
          strokeWidth: 5,
        ),
        child: Builder(
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
                    obscureText: !_isVisible,
                    decoration: InputDecoration(
                      suffix: Container(
                        height: 15,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          color: Colors.grey,
                          icon: Icon(_isVisible? Icons.visibility_off :Icons.visibility, color: Colors.grey,),
                          onPressed: (){
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      setState(() {
                        _isSaving = true;
                      });
                      int res = await userLogin(email, password);
                      if(res == 1){
                        print("getting current user");
                        var res = await Backendless.userService.currentUser();
                        print("Got the user $res");
                        setState(() {
                          _isSaving = false;
                        });
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(currentUseremail: res.email,)));

                      }
                      else{
                        setState(() {
                          _isSaving = false;
                        });
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
      ),
    );
  }
}
