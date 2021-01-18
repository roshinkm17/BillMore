import 'package:flutter/material.dart';

class RegistrationScreenOne extends StatefulWidget {
  RegistrationScreenOne({Key key}): super(key: key);
  static String id = "registration_screen_one_id";
  @override
  _RegistrationScreenOneState createState() => _RegistrationScreenOneState();
}

class _RegistrationScreenOneState extends State<RegistrationScreenOne> {
  @override
  List<String> _gstRegisered = ['Yes', 'No'];
  String _gstReg = "Yes";
  List<String> _gstAssistance = ['Yes', 'No'];
  String _
  List<String> _bussinessType = ['Manufacturer', 'Wholesaler', 'Distributor', 'Retailer', 'Services', "Others"];
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Are you registered under GST?", style: TextStyle(fontSize: 18),),
              SizedBox(height: 10),
              DropdownButton(
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                value: _gstReg,
                onChanged: (newValue){
                  setState(() {
                    _gstReg = newValue;
                  });
                },
                items: _gstRegisered.map((option){
                  return DropdownMenuItem(
                    child: new Text(option),
                    value: option,
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text("Do you need assistance on registration with GST?", style: TextStyle(fontSize: 18),),
              SizedBox(height: 10),
              DropdownButton(
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                value: _gstReg,
                onChanged: (newValue){
                  setState(() {
                    _gstReg = newValue;
                  });
                },
                items: _gstRegisered.map((option){
                  return DropdownMenuItem(
                    child: new Text(option),
                    value: option,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
