import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:biller/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}): super(key: key);
  static String id = "home_screen_id";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    BackendlessUser user = await Backendless.userService.currentUser();
    setState(() {
      currentUser = user;
    });
  }

  BackendlessUser currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () async{
          await Backendless.userService.logout();
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
        },
      ),
      body: Builder(
        builder:(context) => SafeArea(
          child: Column(),
        ),
      ),
    );
  }
}
