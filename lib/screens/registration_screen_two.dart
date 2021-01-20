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

class _RegistrationScreenTwoState extends State<RegistrationScreenTwo> with AutomaticKeepAliveClientMixin {
  Company company = new Company();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map<String, String>;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Need some more details",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    args['gst'] == "Yes"
                        ? CustomInputField(
                            placeholder: "GST Number",
                            onChanged: (value) {
                              setState(() {
                                company.gstNumber = value;
                              });
                            },
                          )
                        : SizedBox(height: 0),
                    args['gst'] == "Yes"
                        ? SizedBox(height: 10) : SizedBox(height: 0),
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
                      keyboardType: TextInputType.phone,
                      placeholder: "Phone Number",
                      onChanged: (value) {
                        setState(() {
                          company.phone = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    CustomInputField(
                      keyboardType: TextInputType.emailAddress,
                      placeholder: "Email ID",
                      onChanged: (value) {
                        setState(() {
                          company.email = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintText: "Password",
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Cannot be empty";
                          } else if (value.length <= 6) {
                            return "Password cannot be less than 6 characters";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            company.password = value;
                          });
                        }),
                    SizedBox(height: 10),
                    CustomInputField(
                      keyboardType: TextInputType.phone,
                      placeholder: "Mobile Number",
                      onChanged: (value) {
                        setState(() {
                          company.mobile = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              MainButton(
                buttonText: "Continue",
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if(args['gst'] == "No"){
                      setState(() {
                        company.gstNumber = "null";
                      });
                    }
                    company.businessType = args['businessType'];
                    Navigator.pushNamed(context, RegistrationScreenThree.id,
                        arguments: {'company': company});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
