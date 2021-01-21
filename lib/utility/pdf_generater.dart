import 'dart:io';
import 'package:biller/utility/bill.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final pdf = pw.Document();
writeOnPdf({Bill bill, var dbDetails, var gstAmount, bool isAddressSame}) async {
  List<List<dynamic>> amountSection = [
    <String>['   ', '  ', '   '],
    <String>['Taxable Amount', '  ', '${bill.taxableAmount}'],
    <String>['CGST ', '  ', '${double.parse((bill.gstAmount/2).toStringAsFixed(1))}'],
    <String>['SGST ', ' ', '${double.parse((bill.gstAmount/2).toStringAsFixed(1))}'],
    <String>['Discount', '  ', '- ${bill.discount}'],
    <String>['Grand Total', '  ', '${bill.totalAmount}'],
    <String>['Advance', '  ', '- ${bill.advanceAmount}'],
    <String>['Balance', '  ', '${bill.balanceAmount}'],
  ];
  List<List<dynamic>> items = [];
  List<List<dynamic>> charges = [];
  for(var charge in bill.chargeList){
      var newCharge = [];
      newCharge.add(charge['name']);
      newCharge.add(' ');
      newCharge.add(charge['amount']);
      charges.add(newCharge);
    }
    amountSection.insertAll(3,charges);
  for (var item in bill.itemList) {
    var newItem = [];
    newItem.add(item['name']);//name
    newItem.add(item['qty']);//qty
    newItem.add(item['price']);//mrp
    var taxAmt =  double.parse((item['price'] * item['qty'])*(bill.gstPercentage/100).toStringAsFixed(1));
    newItem.add(taxAmt);
    newItem.add((item['price'] * item['qty']) + taxAmt);//total amount
    items.add(newItem);
  }
  final profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/ic_launcher.png'))
          .buffer
          .asUint8List());

  pdf.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    margin: pw.EdgeInsets.all(32),
    build: (pw.Context context) {
      return <pw.Widget>[
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Image(profileImage),
            pw.SizedBox(width: 25),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  dbDetails['name'],
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 25),
                ),
                pw.Text(dbDetails['address'],
                    style: pw.TextStyle(fontSize: 16)),
                pw.Row(
                  children: [
                    pw.Text(
                      "MOB: ${dbDetails['mobile']}",
                      style: pw.TextStyle(fontSize: 16),
                    ),
                    pw.SizedBox(width: 25),
                    pw.Text(
                      "GST: ${dbDetails['gstNumber']}",
                      style: pw.TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        //
        //
        //
        pw.SizedBox(height: 20),
        pw.Divider(thickness: 5),
        pw.SizedBox(height: 20),
        //
        //
        //Invoice
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Invoice No.: ${bill.invoiceNumber}'),
                pw.Text(isAddressSame ? 'Bill and Ship to' : 'Bill to'),
                pw.Text('${bill.nameOfShippingParty}'),
                pw.Text('${bill.addressOfShippingParty}'),
              ],
            ),
            isAddressSame ? pw.SizedBox(height: 0) : pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('                  '),
                pw.Text('                  '),
                pw.Text('                   '),
                pw.Text('Ship To'),
                pw.Text('${bill.nameOfBillingParty}'),
                pw.Text('${bill.addressOfBillingParty}'),
              ],
            ),
            pw.Text('Invoice Due Date: ${bill.dueDate}'),
          ],
        ), //
        //
        //
        pw.SizedBox(height: 20),
        pw.Divider(thickness: 5),
        pw.SizedBox(height: 20),
        //
        //
        pw.Table.fromTextArray(
          border: pw.TableBorder(top: pw.BorderSide.none),
          context: context,
          cellAlignment: pw.Alignment.center,
          headers: <String>['ITEM', 'QTY.', 'MRP', 'TAX', 'AMOUNT'],
          data: items,
        ),
        //
        //
        //
        pw.SizedBox(height: 20),
        pw.Divider(thickness: 5),
        pw.SizedBox(height: 20),
        //
        //
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.SizedBox(
              width: 25,
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Bank Details'),
                pw.Text(dbDetails['bankName']),
                pw.Text('IFSE Code: ${dbDetails['ifscCode']}'),
                pw.Text('Account No.: ${dbDetails['accNumber']}'),
                pw.Text('Bank and Branch : ${dbDetails['bankName']} ${dbDetails['branch']}'),
                pw.SizedBox(height: 25),
                pw.Text('Terms and conditions : '),
                pw.Text(
                    'The terms and conditions for this invoice are written here.'),
              ],
            ),
            pw.Table.fromTextArray(
              border: pw.TableBorder(top: pw.BorderSide.none),
              cellPadding: pw.EdgeInsets.all(2),
              cellStyle: pw.TextStyle(fontSize: 16),
              context: context,
              cellAlignment: pw.Alignment.centerRight,
              data: amountSection,
            ),
            pw.SizedBox(width: 25)
          ],
        ),

        //
        //

        pw.Container(
            margin: pw.EdgeInsets.all(50),
            alignment: pw.Alignment.centerRight,
            width: double.maxFinite,
            child: pw.Column(
                children: [pw.Image(profileImage), pw.Text('Signature')])),
      ];
    },
  ));
}

Future savePdf() async {
  Directory documentDirectory = await getApplicationDocumentsDirectory();
  String documentPath = documentDirectory.path;
  print('Document path' + documentPath);
  File file = File("/storage/emulated/0/Download/example.pdf");
  file.writeAsBytesSync(await pdf.save());
}

