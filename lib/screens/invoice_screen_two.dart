import 'dart:io';
import 'package:intl/intl.dart';
import 'package:biller/components/CustomInputField.dart';
import 'package:biller/components/mainButton.dart';
import 'file:///C:/Users/Roshin/Desktop/Biller/App/biller/lib/utility/pdf_generater.dart';
import 'package:biller/screens/pdf_preview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:biller/utility/bill.dart';
import 'package:biller/components/addButton.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import '../constants.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({Key key, this.bill, this.isSame}) : super(key: key);
  final Bill bill;
  final bool isSame;
  static String id = "invoice_screen_id";
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen>
    with AutomaticKeepAliveClientMixin {


  final _formKey = GlobalKey<FormState>();
  Bill bill = Bill();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  List<Widget> itemList = [];
  List<Widget> chargesList = [];
  bool _isAddressSame;
  var itemCount = 0;
  var chargeCount = 0;
  bool _isSaving = false;


  initState(){
    super.initState();
    setState(() {
      bill = widget.bill;
      _isAddressSame = widget.isSame;
      print(bill.nameOfShippingParty);
    });
  }
  int refreshAmounts(){
    bill.totalAmount = 0;
    print(bill.gstPercentage.runtimeType);
    for(var item in bill.itemList){
      if(item['name'] == null || item['qty'] == null || item['unit'] == null || item['price'] == null || item['hsn'] ==  null){
        return 1;
      }
      setState(() {
        bill.totalAmount = bill.totalAmount +((item['price']) * (item['qty']));
      });
    }
    setState(() {
      bill.taxableAmount = bill.totalAmount;
    });
    for(var charge in bill.chargeList){
      if(charge['amount'] == null || charge['name'] == null){
        return 1;
      }
      else{
      setState(() {
        bill.totalAmount = bill.totalAmount +(charge['amount']);
      });
      }
    }
    print("charge amount ${bill.totalAmount}");
    setState(() {
      bill.gstAmount = (bill.gstPercentage/100)*bill.totalAmount;
      if(bill.discount.runtimeType == String){
        bill.totalAmount = bill.totalAmount - int.parse(bill.discount)+ bill.gstAmount;
      }
      else{
        bill.totalAmount = bill.totalAmount - (bill.discount)+ bill.gstAmount;
      }
      if(bill.advanceAmount.runtimeType == String){
      bill.balanceAmount = (bill.totalAmount - int.parse(bill.advanceAmount));
      }else{
        bill.balanceAmount = (bill.totalAmount - (bill.advanceAmount));
      }
    });
    return 0;
  }
  getDetailsFromDatabase() async{
    DataQueryBuilder queryBuilder = DataQueryBuilder();
    queryBuilder.whereClause = "email = 'abcd@gmail.com'";
    var userDetails = await Backendless.data.of("UserDetails").find(queryBuilder);
    print("Details from database aquired!");
    return userDetails;
  }
  roundNumbers(){
    setState(() {
      bill.balanceAmount = double.parse(bill.balanceAmount.toStringAsFixed(1));
      bill.totalAmount = double.parse(bill.totalAmount.toStringAsFixed(1));
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isSaving,
        progressIndicator: CircularProgressIndicator(strokeWidth: 5),
        child: Builder(
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
                              Map<String, dynamic> item = new Map();
                              setState(() {
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
                                        item['qty'] = double.parse(value);
                                      });
                                    },
                                    unitOnChanged: (value) {
                                      setState(() {
                                        item['unit'] = value;
                                      });
                                    },
                                    priceOnChanged: (value) {
                                      setState(() {
                                        item['price'] = double.parse(value);
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
                                          item['qty'] = double.parse(value);
                                        });
                                      },
                                      unitOnChanged: (value) {
                                        setState(() {
                                          item['unit'] = value;
                                        });
                                      },
                                      priceOnChanged: (value) {
                                        setState(() {
                                          item['price'] = double.parse(value);
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
                              Map<String, dynamic> charge = new Map();
                              setState(() {
                                if (chargeCount == 0) {
                                  chargesList.add(
                                    new Charges(
                                      onChargeValueChange: (value) {
                                        setState(() {
                                          charge['amount'] = double.parse(value);
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
                                          charge['amount'] = double.parse(value);
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
                                bill.discount = double.parse(value);
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
                            bill.gstPercentage = double.parse(value);
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
                        "\u20b9 ${bill.totalAmount.toStringAsFixed(1)}",
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
                                    bill.advanceAmount = double.parse(value);
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
                        "\u20b9 ${bill.balanceAmount.toStringAsFixed(1)}",
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
                            "${bill.dueDate}",
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
                                  firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null &&
                                    pickedDate != bill.dueDate) {
                                  setState(() {
                                    bill.dueDate = formatter.format(pickedDate);
                                    print(bill.dueDate);
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
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        roundNumbers();
                        setState(() {
                          _isSaving = true;
                        });
                        var dbDetails = await getDetailsFromDatabase();
                        String fullPath = "/storage/emulated/0/Download/example.pdf";
                        // try{
                        //   File file = await File(fullPath);
                        //   await file.delete();
                        // }catch(e){
                        //   print("sorry");
                        // }

                        await writeOnPdf(
                          bill: bill,
                          dbDetails: dbDetails[0],
                          isAddressSame: _isAddressSame,
                          gstAmount: bill.gstAmount,
                        );
                        await savePdf();
                        print(fullPath);
                        setState(() {
                          _isSaving = false;
                        });
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => PdfPreviewScreen(
                                  path: fullPath,
                                  docName: bill.invoiceNumber,
                                )));
                      }
                      //Bill preview screen
                    },
                  ),
                ],
              ),
            ),
          )),
        ),
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
