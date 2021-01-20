import 'package:biller/components/mainButton.dart';
import 'package:biller/screens/registration_screen_two.dart';
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
  String _gstHelp = "Yes";
  List<String> _businessType = ['Manufacturer', 'Wholesaler', 'Distributor', 'Retailer', 'Services', "Others"];
  String _type = "Manufacturer";
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Are you registered under GST?", style: TextStyle(fontSize: 18),),
                  SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(30),
                        )
                      ),
                      child: DropdownButton(
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.black,
                        // ),
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
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 2),
                  SizedBox(height: 20),
                  Text("Do you need assistance on registration with GST?", style: TextStyle(fontSize: 18),),
                  SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                        )
                      ),
                      child: DropdownButton(
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        value: _gstHelp,
                        onChanged: (newValue){
                          setState(() {
                            _gstHelp = newValue;
                          });
                        },
                        items: _gstAssistance.map((option){
                          return DropdownMenuItem(
                            child: new Text(option),
                            value: option,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 2),
                  SizedBox(height: 20),
                  Text("What is the type of Business?", style: TextStyle(fontSize: 18),),
                  SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Colors.black)
                        )
                      ),
                      child: DropdownButton(
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        value: _type,
                        onChanged: (newValue){
                          setState(() {
                            _type = newValue;
                          });
                        },
                        items: _businessType.map((option){
                          return DropdownMenuItem(
                            child: new Text(option),
                            value: option,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              MainButton(
                buttonText: "Continue",
                onPressed: (){
                  Navigator.pushNamed(context, RegistrationScreenTwo.id, arguments: {"gst": _gstReg, "businessType": _type});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
