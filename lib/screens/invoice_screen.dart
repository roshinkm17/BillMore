import 'dart:math';
import 'package:biller/components/CustomInputField.dart';
import 'package:biller/components/mainButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:biller/utility/bill.dart';
import 'package:biller/components/addButton.dart';
import '../constants.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({Key key}) : super(key: key);
  static String id = "invoice_screen_id";
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final Random invoice = new Random(1000000);
  Bill bill = new Bill();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: ListView(
            children: [
              Text(
                "Bill/Invoice",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("Invoice No: ", style: TextStyle(fontSize: 16),),
                  Text(
                    invoice.nextInt(1000000).toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),//Invoice number
              SizedBox(
                height: 10,
              ),
              CustomInputField(
                placeholder: "Party's name",
                onChanged: (value){
                    setState(() {
                      bill.nameOfParty = value;
                    });
                },
              ),//Party's name
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Items", style: TextStyle(fontSize: 16)),
                  AddButton(
                    buttonText: "Add",
                    onPressed: (){},
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomInputField(
                      placeholder: "Name",
                      onChanged: (value){},
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: CustomInputField(
                      placeholder: "Qty",
                      onChanged: (value){},
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: CustomInputField(
                      placeholder: "Kg",
                      onChanged: (value){},
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: CustomInputField(
                      placeholder: "\$",
                      onChanged: (value){},
                    ),
                  ),
                ],
              ),//Items
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Charges", style: TextStyle(fontSize: 16)),
                  AddButton(
                    buttonText: "Add",
                    onPressed: (){},
                  ),
                ],
              ),//Charges
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discount", style: TextStyle(fontSize: 16)),
                  AddButton(
                    buttonText: "Add",
                    onPressed: (){},
                  ),
                ],
              ),//Discount
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("GST", style: TextStyle(fontSize: 16)),
                  AddButton(
                    buttonText: "Add",
                    onPressed: (){},
                  ),
                ],
              ),//GST
              SizedBox(height: 10),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: TextStyle(fontSize: 16)),
                  Text("15897", style: TextStyle(fontSize: 20, color: buttonColor,letterSpacing: 10, fontWeight: FontWeight.bold),)
                ],
              ),//Total
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                      child: Text("Advance", style: TextStyle(fontSize: 16))),
                  // AddButton(
                  //   buttonText: "Add",
                  //   onPressed: (){},
                  // ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: Text("-", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: buttonColor),)),
                        Expanded(
                          flex: 5,
                          child: CustomInputField(
                            placeholder: "0",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),//Advance
              SizedBox(height: 10),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Balance", style: TextStyle(fontSize: 16)),
                  Text("14546", style: TextStyle(fontSize: 20, color: buttonColor,letterSpacing: 10, fontWeight: FontWeight.bold),)
                ],
              ),//Balance
              SizedBox(height: 10),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Due Date", style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Text("${selectedDate.day}/ ${selectedDate.month}/ ${selectedDate.year}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff255c99),
                        ),
                        child: IconButton(
                          onPressed: () async{
                            print("pressed date");
                            //Date picker
                            var pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015, 08),
                              lastDate: DateTime(2100),
                            );
                            if(pickedDate != null && pickedDate != selectedDate){
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          icon: Icon(Icons.calendar_today_rounded),
                          iconSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),//Due Date
              SizedBox(height: 30),
              MainButton(
                buttonText: "Save and Preview",
                onPressed: (){
                  //Bill preview screen
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
