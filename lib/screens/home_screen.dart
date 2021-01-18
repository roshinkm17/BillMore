import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}): super(key: key);
  static String id = "home_screen_id";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),),
      body: SafeArea(
        child: Column(),
      ),
    );
  }
}
