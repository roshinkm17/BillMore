import 'package:flutter/material.dart';
import 'package:biller/components/CustomInputField.dart';
import 'package:biller/utility/bill.dart';
import 'package:biller/components/mainButton.dart';
import 'package:biller/screens/invoice_screen_two.dart';

class InvoiceScreenOne extends StatefulWidget {
  InvoiceScreenOne({Key key, this.layoutNumber}): super(key: key);
  final layoutNumber;
  @override
  _InvoiceScreenOneState createState() => _InvoiceScreenOneState();
}

class _InvoiceScreenOneState extends State<InvoiceScreenOne> with AutomaticKeepAliveClientMixin{
  Bill bill = new Bill();
  bool _isAddressSame = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Builder(
          builder: (context) => SafeArea(
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
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
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
                  SizedBox(height: 30),
                  MainButton(
                    buttonText: "Continue",
                    onPressed: (){
                      if (_formKey.currentState.validate()){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InvoiceScreen(bill: bill, isSame: _isAddressSame, layoutNumber: widget.layoutNumber,),),);
                      }
                      else{
                        final snackbar = SnackBar(
                          content: Text("Fields have to be filled"),
                          duration: Duration(seconds: 2),
                        );
                        Scaffold.of(context).showSnackBar(snackbar);
                      }
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
  @override
  bool get wantKeepAlive => true;
}
