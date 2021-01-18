import 'package:biller/components/CustomInputField.dart';
import 'package:flutter/material.dart';
import 'package:biller/utility/company.dart';

class RegistrationScreenTwo extends StatefulWidget {
  RegistrationScreenTwo({Key key}) : super(key: key);
  static String id = "registration_screen_two_id";
  @override
  _RegistrationScreenTwoState createState() => _RegistrationScreenTwoState();
}

class _RegistrationScreenTwoState extends State<RegistrationScreenTwo> {
  Company company = new Company();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Need some more details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputField(
                    placeholder: "Name of the firm",
                    onChanged: (value) {
                      setState(() {
                        company.name = value;
                      });
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
