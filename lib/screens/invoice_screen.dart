import 'dart:math';
import 'package:biller/components/CustomInputField.dart';
import 'package:biller/components/mainButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:biller/utility/bill.dart';
import 'package:biller/components/addButton.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({Key key}) : super(key: key);
  static String id = "invoice_screen_id";
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen>
    with AutomaticKeepAliveClientMixin {
  final Random invoice = new Random(1000000);
  Bill bill = new Bill();
  DateTime selectedDate = DateTime.now();
  List<Widget> itemList = [];
  List<Widget> chargesList = [];
  var itemCount = 0;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  Text(
                    "Invoice No: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "1234",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ), //Invoice number
              SizedBox(
                height: 10,
              ),
              CustomInputField(
                placeholder: "Party's name",
                onChanged: (value) {
                  setState(() {
                    bill.nameOfParty = value;
                  });
                },
              ), //Party's name
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Items", style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (itemList.length > 0) {
                            setState(() {
                              itemList.removeLast();
                              if(itemCount == 1){
                                bill.itemList.removeLast();
                                itemCount--;
                              }else{
                                bill.itemList.removeAt(itemCount-2);
                                itemCount--;
                              }
                            });
                          }
                          print(itemCount);
                        },
                        icon: Icon(Icons.delete_rounded),
                        iconSize: 18,
                        color: Colors.grey[700],
                      ),
                      AddButton(
                        buttonText: "+",
                        onPressed: () {
                          Map<String, String> item = new Map();
                          setState(() {
                            if(itemCount == 0){
                              itemList.add(new ItemInfo(
                                nameOnChanged: (value) {
                                  setState(() {
                                    item['name'] = value;
                                  });
                                },
                                qtyOnChanged: (value) {
                                  setState(() {
                                    item['qty'] = value;
                                  });
                                },
                                unitOnChanged: (value) {
                                  setState(() {
                                    item['unit'] = value;
                                  });
                                },
                                priceOnChanged: (value) {
                                  item['price'] = value;
                                },
                              ));
                              bill.itemList.add(item);
                              itemCount++;
                            }
                            print(bill.itemList);
                            print(itemCount);
                            if(itemCount > 0) {
                              if (bill.itemList[itemCount - 1]['name'] ==
                                  null ||
                                  bill.itemList[itemCount - 1]['qty'] == null ||
                                  bill.itemList[itemCount - 1]['unit'] ==
                                      null ||
                                  bill.itemList[itemCount - 1]['price'] ==
                                      null) {
                                final snackBar = SnackBar(
                                  content: Text('Complete existing item!'),
                                  duration: Duration(seconds: 3),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                              else {
                                itemList.add(new ItemInfo(
                                  nameOnChanged: (value) {
                                    setState(() {
                                      item['name'] = value;
                                    });
                                  },
                                  qtyOnChanged: (value) {
                                    setState(() {
                                      item['qty'] = value;
                                    });
                                  },
                                  unitOnChanged: (value) {
                                    setState(() {
                                      item['unit'] = value;
                                    });
                                  },
                                  priceOnChanged: (value) {
                                    item['price'] = value;
                                  },
                                ));
                                bill.itemList.add(item);
                                itemCount++;
                              }
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ), //Items
              //Items List
              Column(
                children: itemList,
              ), //Item list
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Charges", style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          print("delete");
                          if (chargesList.length > 0) {
                            setState(() {
                              chargesList.removeLast();
                            });
                          }
                        },
                        icon: Icon(Icons.delete_rounded),
                        iconSize: 18,
                        color: Colors.grey[700],
                      ),
                      AddButton(
                        buttonText: "Add",
                        onPressed: () {
                          setState(() {
                            chargesList.add(Charges());
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ), //Charges
              //List of Charges
              Column(
                children: chargesList,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 2,
                      child: Text("Discount", style: TextStyle(fontSize: 16))),
                  Expanded(
                    child: CustomInputField(
                      placeholder: "\u20B9",
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ), //Discount
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("GST", style: TextStyle(fontSize: 16)),
                  Text(
                    "18%",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ), //GST
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
                  Text(
                    "15897",
                    style: TextStyle(
                        fontSize: 20,
                        color: buttonColor,
                        letterSpacing: 10,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ), //Total
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
                        Expanded(
                            child: Text(
                          "-",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: buttonColor),
                        )),
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
              ), //Advance
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
                  Text(
                    "14546",
                    style: TextStyle(
                        fontSize: 20,
                        color: buttonColor,
                        letterSpacing: 10,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ), //Balance
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
                      Text(
                        "${selectedDate.day}/ ${selectedDate.month}/ ${selectedDate.year}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: buttonColor,
                        ),
                        child: IconButton(
                          onPressed: () async {
                            print("pressed date");
                            //Date picker
                            var pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2015, 08),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null &&
                                pickedDate != selectedDate) {
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
              ), //Due Date
              SizedBox(height: 30),
              MainButton(
                buttonText: "Save and Preview",
                onPressed: () {
                  //Bill preview screen
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ItemInfo extends StatelessWidget {
  ItemInfo(
      {this.nameOnChanged,
      this.qtyOnChanged,
      this.unitOnChanged,
      this.priceOnChanged});
  final Function nameOnChanged, qtyOnChanged, unitOnChanged, priceOnChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: CustomInputField(
              placeholder: "Name",
              onChanged: nameOnChanged,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: CustomInputField(
              keyboardType: TextInputType.number,
              placeholder: "Qty",
              onChanged: qtyOnChanged,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: CustomInputField(
              placeholder: "Kg",
              onChanged: unitOnChanged,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: CustomInputField(
              placeholder: "\u20b9",
              keyboardType: TextInputType.number,
              onChanged: priceOnChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class Charges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: CustomInputField(
              placeholder: "Charge name",
              onChanged: (value) {},
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: CustomInputField(
              placeholder: "\$",
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
