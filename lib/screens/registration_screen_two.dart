
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:biller/components/CustomInputField.dart';
import 'package:biller/components/mainButton.dart';
import 'package:biller/screens/registration_screen_three.dart';
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
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Need some more details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  CustomInputField(
                    placeholder: "Name of the firm",
                    onChanged: (value) {
                      setState(() {
                        company.name = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  CustomInputField(
                    placeholder: "GST Number",
                    onChanged: (value) {
                      setState(() {
                        company.gstNumber = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  CustomInputField(
                    placeholder: "Address",
                    onChanged: (value) {
                      setState(() {
                        company.address = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  CustomInputField(
                    placeholder: "Phone Number",
                    onChanged: (value) {
                      setState(() {
                        company.phone = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  CustomInputField(
                    placeholder: "Email ID",
                    onChanged: (value) {
                      setState(() {
                        company.email = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: "Password",
                    ),
                    obscureText: true,
                    onChanged: (value){
                      setState(() {
                        company.password = value;
                      });
                    }
                  ),
                  SizedBox(height: 10),
                  CustomInputField(
                    placeholder: "Mobile Number",
                    onChanged: (value) {
                      setState(() {
                        company.mobile = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              MainButton(
                buttonText: "Continue",
                onPressed: () async{
                  BackendlessUser user = BackendlessUser();
                  user.email = company.email;
                  user.password = company.password;
                  await Backendless.userService.register(user);
                  Navigator.pushNamed(context, RegistrationScreenThree.id);
                },
              ),
            ],
          ),

        ),
      ),
    );
  }
}
