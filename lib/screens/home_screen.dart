import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:biller/components/mainButton.dart';
import 'package:biller/constants.dart';
import 'package:biller/screens/layout_screen.dart';
import 'package:biller/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  static String id = "home_screen_id";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    BackendlessUser user = await Backendless.userService.currentUser();
    setState(() {
      currentUser = user;
    });
  }

  BackendlessUser currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        actions: [
          IconButton(
            icon: Icon(Icons.settings_rounded, color: Colors.white,),
            iconSize: 20,
            onPressed: (){
              //to Settings
            },
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text(currentUser.email),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        child: Icon(Icons.exit_to_app),
        onPressed: () async {
          await Backendless.userService.logout();
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
        },
      ),
      body: Builder(
        builder: (context) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainButton(
                    buttonText: "Create New Invoice",
                    onPressed: () {
                      Navigator.pushNamed(context, LayoutScreen.id);
                    },
                  ),
                  SizedBox(height: 20),
                  MainButton(
                    buttonText: "View Invoices",
                    onPressed: (){
                      print("view invoices");
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
