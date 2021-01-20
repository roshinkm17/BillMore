import 'package:flutter/material.dart';

class Bill{
  String nameOfShippingParty;
  String addressOfShippingParty;
  String nameOfBillingParty;
  String addressOfBillingParty;
  var itemList = [];
  var chargeList = [];
  var discount;
  var advanceAmount;
  var totalAmount;
  var balanceAmount;
  var dueDate;
  var gst;
  var invoiceNumber;
  Bill(){
    this.totalAmount = "0";
    this.advanceAmount = "0";
    this.discount = "0";
    this.balanceAmount = "0";
    this.gst = "18";
  }
}