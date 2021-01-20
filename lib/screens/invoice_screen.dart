import 'dart:math';
import 'package:biller/components/CustomInputField.dart';
import 'package:biller/components/mainButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:biller/utility/bill.dart';
import 'package:biller/components/addButton.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
  final _formKey = GlobalKey<FormState>();
  Bill bill = new Bill();
  DateTime selectedDate = DateTime.now();
  List<Widget> itemList = [];
  List<Widget> chargesList = [];
  bool _isAddressSame = false;
  var itemCount = 0;
  var chargeCount = 0;
  var gstAmount = 0.0;
  TextEditingController _controller;
  initState(){
    super.initState();
  }
  int refreshAmounts(){
    bill.totalAmount = 0;
    for(var item in bill.itemList){
      if(item['name'] == null || item['qty'] == null || item['unit'] == null || item['price'] == null || item['hsn'] ==  null){
        return 1;
      }
      setState(() {
        bill.totalAmount = bill.totalAmount + (int.parse(item['price']) * int.parse(item['qty']));
      });
    }
    for(var charge in bill.chargeList){
      if(charge['amount'] == null || charge['name'] == null){
        return 1;
      }
      else{
      setState(() {
        bill.totalAmount = bill.totalAmount + int.parse(charge['amount']);
      });
      }
    }
    setState(() {
      gstAmount = ((int.parse(bill.gst))/100)*bill.totalAmount;
      print(gstAmount);
      bill.totalAmount = bill.totalAmount - int.parse(bill.discount) + gstAmount;
      bill.balanceAmount = bill.totalAmount - int.parse(bill.advanceAmount);
      bill.balanceAmount.toStringAsFixed(1);
    });
    return 0;
  }
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
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
                    Expanded(
                      child: CustomInputField(
                        placeholder: "Invoice Number",
                        onChanged: (value) {
                          setState(() {
                            bill.invoiceNumber = value;
                          });
                        },
                      ),
                    ),
                  ],
                ), //Invoice number
                SizedBox(height: 10),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Is Shipping and Billing address the same?"),
                    Checkbox(
                      value: this._isAddressSame,
                      onChanged: (value) {
                        setState(() {
                          this._isAddressSame = value;
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  _isAddressSame ? "Shipping/Billing address" :"Shipping address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                //Shipping Address
                Column(
                  children: [
                    CustomInputField(
                      placeholder: "Name",
                      onChanged: (value) {
                        setState(() {
                          bill.nameOfShippingParty = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    CustomInputField(
                      placeholder: "Address",
                      onChanged: (value){
                        setState(() {
                          bill.addressOfShippingParty = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                //Billing Address
                _isAddressSame
                    ? SizedBox(height: 0)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Billing address",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          CustomInputField(
                            placeholder: "Name",
                            onChanged: (value) {
                              setState(() {
                                bill.nameOfBillingParty = value;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          CustomInputField(
                            placeholder: "Address",
                            onChanged: (value){
                              setState(() {
                                bill.addressOfBillingParty = value;
                              });
                            },
                          ),
                        ],
                      ),
                SizedBox(height: 20),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
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
                                if (itemCount == 1) {
                                  bill.itemList.removeAt(itemCount-1);
                                  itemCount--;
                                } else {
                                  bill.itemList.removeAt(itemCount - 1);
                                  itemCount--;
                                }
                              });
                            }
                            print(itemCount);
                            print(bill.itemList);
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
                              bill.dueDate = selectedDate;
                              if (itemCount == 0) {
                                itemList.add(new ItemInfo(
                                  nameOnChanged: (value) {
                                    setState(() {
                                      item['name'] = value;
                                      print(bill.itemList);
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
                                    setState(() {
                                      item['price'] = value;
                                    });
                                  },
                                  hsnOnChanged: (value){
                                    setState(() {
                                      item['hsn'] = value;
                                    });
                                  },
                                ));
                                bill.itemList.add(item);
                                itemCount++;
                              }
                              print(bill.itemList);
                              print(itemCount);
                              if (itemCount > 0) {
                                if (bill.itemList[itemCount - 1]['name'] ==
                                        null ||
                                    bill.itemList[itemCount - 1]['qty'] ==
                                        null ||
                                    bill.itemList[itemCount - 1]['unit'] ==
                                        null ||
                                    bill.itemList[itemCount - 1]['price'] ==
                                        null ||
                                    bill.itemList[itemCount - 1]['hsn'] ==
                                        null) {
                                  final snackBar = SnackBar(
                                    content: Text('Complete existing item!'),
                                    duration: Duration(seconds: 3),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  itemList.add(new ItemInfo(
                                    nameOnChanged: (value) {
                                      setState(() {
                                        item['name'] = value;
                                        print(bill.itemList);
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
                                      setState(() {
                                        item['price'] = value;
                                      });
                                    },
                                    hsnOnChanged: (value){
                                      setState(() {
                                        item['hsn'] = value;
                                      });
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
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Charges", style: TextStyle(fontSize: 16)),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (chargesList.length > 0) {
                              setState(() {
                                chargesList.removeLast();
                                if (chargeCount == 1) {
                                  bill.chargeList.removeAt(chargeCount-1);
                                  chargeCount--;
                                } else {
                                  bill.chargeList.removeAt(chargeCount-1);
                                  chargeCount--;
                                }
                              });
                            }
                            print(chargeCount);
                          },
                          icon: Icon(Icons.delete_rounded),
                          iconSize: 18,
                          color: Colors.grey[700],
                        ),
                        AddButton(
                          buttonText: "+",
                          onPressed: () {
                            Map<String, String> charge = new Map();
                            setState(() {
                              if (chargeCount == 0) {
                                chargesList.add(
                                  new Charges(
                                    onChargeValueChange: (value) {
                                      setState(() {
                                        charge['amount'] = value;
                                        print(value);
                                      });
                                    },
                                    onChargeNameChange: (value) {
                                      setState(() {
                                        charge["name"] = value;
                                      });
                                    },
                                  ),
                                );
                                bill.chargeList.add(charge);
                                chargeCount++;
                              }
                              print(bill.chargeList);
                              print(chargeCount);
                              if (chargeCount > 0) {
                                if (bill.chargeList[chargeCount - 1]['name'] ==
                                        null ||
                                    bill.chargeList[chargeCount - 1]
                                            ['amount'] ==
                                        null) {
                                  final snackBar = SnackBar(
                                    content: Text('Complete existing charge!'),
                                    duration: Duration(seconds: 3),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  chargesList.add(new Charges(
                                    onChargeValueChange: (value) {
                                      setState(() {
                                        charge['amount'] = value;
                                      });
                                    },
                                    onChargeNameChange: (value) {
                                      setState(() {
                                        charge["name"] = value;
                                      });
                                    },
                                  ));
                                  bill.chargeList.add(charge);
                                  chargeCount++;
                                }
                              }
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
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 3,
                        child:
                            Text("Discount", style: TextStyle(fontSize: 16))),
                    Expanded(
                      child: Container(
                        child: CustomInputField(
                          placeholder: "\u20B9",
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              bill.discount = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ), //Discount
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text("GST", style: TextStyle(fontSize: 16))),
                    Expanded(
                      child: CustomInputField(
                        placeholder: "18%(default)",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          bill.gst = value;
                        },
                      ),
                    ),
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
                    Row(
                      children: [
                        Text("Total", style: TextStyle(fontSize: 16)),
                        IconButton(
                          icon: Icon(Icons.refresh),
                          color: Colors.green,
                          onPressed: (){
                            print("refresh");
                            if(refreshAmounts() == 1){
                              final snackBar = SnackBar(
                                content: Text('Partially Entered Fields Found. Complete to apply changes'),
                                duration: Duration(seconds: 3),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          },
                        ),
                      ],
                    ),
                    Text(
                      "\u20b9 ${bill.totalAmount}",
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
                              keyboardType: TextInputType.number,
                              placeholder: "\u20b9 0",
                              onChanged: (value) {
                                setState(() {
                                  bill.advanceAmount = value;
                                });
                              },
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
                    Row(
                      children: [
                        Text("Balance", style: TextStyle(fontSize: 16)),
                        IconButton(
                          icon: Icon(Icons.refresh),
                          color: Colors.green,
                          onPressed: (){
                            print("refresh");
                            if(refreshAmounts() == 1){
                              final snackBar = SnackBar(
                                content: Text('Partially Entered Fields Found. Complete to apply changes'),
                                duration: Duration(seconds: 3),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          },
                        ),
                      ],
                    ),
                    Text(
                      "\u20b9 ${bill.balanceAmount}",
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
                                  bill.dueDate = selectedDate;
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
                    if (_formKey.currentState.validate()) {
                      print("Party's name: ${bill.nameOfShippingParty}");
                      print("Items: ${bill.itemList}");
                      print("charges: ${bill.chargeList}");
                      print("discount: ${bill.discount}");
                      print("advance: ${bill.advanceAmount}");
                      print("dueDate: ${bill.dueDate}");
                    }
                    //Bill preview screen
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ItemInfo extends StatelessWidget {
  ItemInfo(
      {this.nameOnChanged,
      this.qtyOnChanged,
      this.unitOnChanged,
      this.priceOnChanged,
      this.hsnOnChanged});
  final Function nameOnChanged, qtyOnChanged, unitOnChanged, priceOnChanged, hsnOnChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Column(
        children: [
          Row(
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
                  placeholder: "Ut",
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
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: CustomInputField(
                  placeholder: "HSN",
                  keyboardType: TextInputType.number,
                  onChanged: hsnOnChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Charges extends StatelessWidget {
  Charges({this.onChargeNameChange, this.onChargeValueChange});
  final Function onChargeNameChange, onChargeValueChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: CustomInputField(
              placeholder: "Charge name",
              onChanged: onChargeNameChange,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: CustomInputField(
              keyboardType: TextInputType.number,
              placeholder: "\u20b9",
              onChanged: onChargeValueChange,
            ),
          ),
        ],
      ),
    );
  }
}
