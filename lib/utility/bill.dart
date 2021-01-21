import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  var gstPercentage;
  var gstAmount;
  var taxableAmount;
  var invoiceNumber;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  Bill(){
    this.dueDate = formatter.format(DateTime.now());
    this.discount = 0;
    this.taxableAmount = 0;
    this.totalAmount = 0.0;
    this.advanceAmount = 0;
    this.discount = 0;
    this.balanceAmount = 0.0;
    this.gstPercentage = 18;
    this.gstAmount = 0.0;
  }
}