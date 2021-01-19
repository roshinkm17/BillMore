import 'dart:math';

import 'package:biller/components/CustomInputField.dart';
import 'package:biller/components/mainButton.dart';
import 'package:flutter/material.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({Key key}) : super(key: key);
  static String id = "invoice_screen_id";
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {

  final Random invoice=new Random(1000000);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context)=>SafeArea(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Container(
            child: ListView(
              children: [
                Text("Bill/Invoice",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Invoice No: "),
                        Text(invoice.nextInt(1000000).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("Items"),
                        FlatButton(onPressed: () {},
                            child: Text("Add"),
                        )
                      ],
                    ),
                    CustomInputField(
                      placeholder: "Name",
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                    ),
                    CustomInputField(
                      placeholder: "Qty",
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                    ),
                    CustomInputField(
                      placeholder: "Kg",
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                    ),
                    CustomInputField(
                      placeholder: "Unit Price",
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                    ),
                  ],
                )

              ],
            ),
          ),
        )),
      ),
    );
  }
}
