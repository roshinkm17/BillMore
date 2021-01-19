import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:biller/components/CustomInputField.dart';
import 'package:biller/components/mainButton.dart';
import 'package:biller/constants.dart';
import 'package:biller/screens/home_screen.dart';
import 'package:biller/utility/bank.dart';
import 'package:biller/utility/company.dart';
import 'package:flutter/material.dart';
import 'package:gx_file_picker/gx_file_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

class RegistrationScreenThree extends StatefulWidget {
  RegistrationScreenThree({Key key}) : super(key: key);
  static String id = "registration_screen_three_id";
  @override
  _RegistrationScreenThreeState createState() =>
      _RegistrationScreenThreeState();
}

class _RegistrationScreenThreeState extends State<RegistrationScreenThree> {
  Bank bank = new Bank();
  String _logoName ;
  String _signatureName ;
  final _formKey = GlobalKey<FormState>();
  uploadDetails(Company companyDetails, Bank bankDetails) async{
    Map details = {
      "name": companyDetails.name,
      "phone": companyDetails.phone,
      "mobile": companyDetails.mobile,
      "address": companyDetails.address,
      "businessType": companyDetails.businessType,
      "gstNumber": companyDetails.gstNumber,
      // "signature": companyDetails.signature.toString(),
      // "logo": companyDetails.logo.toString(),
      "bankName": bankDetails.name,
      "ifscCode": bankDetails.ifsc,
      "accNumber": bankDetails.accNumber,
      "branch": bankDetails.branch,
    };
    Backendless.data.of("UserDetails").save(details);
    print(details);
  }

  void registerUser(email, password) async{
    BackendlessUser user = BackendlessUser();
    user.email = email;
    user.password = password;
    await Backendless.userService.register(user);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map<String, Company>;
    return Scaffold(
      body: Builder(
        builder:(context) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text(
                    "Bank Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInputField(
                        placeholder: "Name",
                        onChanged: (value) {
                          setState(() {
                            bank.name = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        placeholder: "IFSC Code",
                        onChanged: (value) {
                          setState(() {
                            bank.ifsc = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        keyboardType: TextInputType.number,
                        placeholder: "Account number",
                        onChanged: (value) {
                          setState(() {
                            bank.accNumber = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        placeholder: "Branch",
                        onChanged: (value) {
                          setState(() {
                            bank.branch = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Upload",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                hintText: _logoName == null ? "Logo (jpeg, jpg, png)" : _logoName,
                              ),
                              onChanged: (value) async{
                              },
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(vertical: 17),
                                color: buttonColor,
                                onPressed: () async{
                                  File file = await FilePicker.getFile(
                                    type: FileType.image,
                                  );
                                  print(file);
                                  setState(() {
                                    args['company'].logo = file;
                                    _logoName = basename(file.path);
                                  });
                                },
                                child: Icon(Icons.attach_file, color: Colors.white,)),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                hintText: _signatureName == null ? "Signature (jpeg, jpg, png)" : _signatureName,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 17),
                                color: buttonColor,
                                onPressed: () async{
                                  File file = await FilePicker.getFile(
                                    type: FileType.image,
                                  );
                                  print(file);
                                  setState(() {
                                    args['company'].signature = file;
                                    _signatureName = basename(file.path);
                                  });
                                },
                                child: Icon(Icons.attach_file, color: Colors.white,)),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  MainButton(
                buttonText: "Continue",
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        if(_logoName != null && _signatureName != null ){
                          //Continue
                          uploadDetails(args['company'], bank);
                          registerUser(args['company'].email, args['company'].password);
                          showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Registered Successfully!"),
                                content: Icon(Icons.check),
                                actions: [
                                  FlatButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("Ok"),
                                  ),
                                ],
                              );
                            }
                          );
                          Future.delayed(const Duration(milliseconds: 1500), (){
                             Navigator.pushNamed(context, HomeScreen.id);
                          });
                        }
                        else{
                          final snackBar = SnackBar(
                            content: Text('Both files have to be uploaded!'),
                            duration: Duration(seconds: 2),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      }
                      print("Upload Done");
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
