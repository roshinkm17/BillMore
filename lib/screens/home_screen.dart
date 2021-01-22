import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:biller/components/mainButton.dart';
import 'package:biller/constants.dart';
import 'package:biller/screens/layout_screen.dart';
import 'package:biller/screens/welcome_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.currentUseremail}) : super(key: key);
  static String id = "home_screen_id";
  final String currentUseremail;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool _isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_rounded,
              color: Colors.white,
            ),
            iconSize: 20,
            onPressed: () {
              //to Settings
            },
          ),
        ],
        automaticallyImplyLeading: false,
        // title: Text(widget.currentUseremail == null ? "" : widget.currentUseremail, style: TextStyle(fontSize: 14),),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 14,
              child: Icon(Icons.person, size: 14),
            ),
            SizedBox(width: 10),
            Text(widget.currentUseremail == null ? "" : widget.currentUseremail, style: TextStyle(fontSize: 14),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        child: Icon(Icons.exit_to_app),
        onPressed: () async {
          setState(() {
            _isSaving = true;
          });
          await Backendless.userService.logout();
          setState(() {
            _isSaving = false;
          });
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
        },
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text("Tap again to close")),
        child: ModalProgressHUD(
          inAsyncCall: _isSaving,
          progressIndicator: CircularProgressIndicator(strokeWidth: 5),
          child: Builder(
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
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: buttonColor,
                              width: 5
                            )
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          onPressed: (){
                            print("View Invoiced");
                          },
                          child: Text("Invoice history", style: TextStyle(fontSize: 18),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
