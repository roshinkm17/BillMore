import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final pdf = pw.Document();

writeOnPdf() async {
  //
  final profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/ic_launcher.png')).buffer.asUint8List());

  pdf.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
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
                  'ABC LTD ',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 25),
                ),
                pw.Text('22, asdasd, sadasda, Bagalore',
                    style: pw.TextStyle(fontSize: 16)),
                pw.Row(
                  children: [
                    pw.Text(
                      'Mobile: 123456789',
                      style: pw.TextStyle(fontSize: 16),
                    ),
                    pw.SizedBox(width: 25),
                    pw.Text(
                      'GSTIN: 00ABCDe000000F0G',
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
        pw.Divider(thickness: 10),
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
                pw.Text('Invoice No.: ABCD01'),
                pw.Text('Bill and Ship To : '),
                pw.Text('LalKrishna'),
                pw.Text('123, ABC Layout,'),
                pw.Text('DEF Nagar, Bangalore'),
                pw.Text('GSTN: 00ABCDR00000G0J'),
              ],
            ),
            pw.Text('Invoice Date: 19-01-2020'),
          ],
        ),
        //
        //
        //
        pw.Divider(thickness: 10),
        pw.SizedBox(height: 20),
        //
        //
        pw.Table.fromTextArray(
          border: pw.TableBorder(top: pw.BorderSide.none),
          context: context,
          cellAlignment: pw.Alignment.center,
          headers: <String>['ITEM', 'QTY.', 'MRP', 'TAX', 'AMOUNT'],
          data: const <List<String>>[
            <String>['1993', 'PDF 1.0', 'Acrobat 1', 'sda', 'asdad'],
          ],
        ),
        //
        //
        //
        pw.Divider(thickness: 10),
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
                pw.Text('Name: asdsad'),
                pw.Text('IFSE Code HDFCXXX000'),
                pw.Text('Account No.: 000000000'),
                pw.Text('Bank and Branch : sdad bank.'),
                pw.SizedBox(height: 25),
                pw.Text('Terms and conditions : '),
                pw.Text('adsdagsdgjagdjsagjdgashgdjagjsdgjagdjasgdjagh'),
              ],
            ),
            pw.Table.fromTextArray(
              border: pw.TableBorder(top: pw.BorderSide.none),
              cellPadding: pw.EdgeInsets.all(2),
              cellStyle: pw.TextStyle(fontSize: 16),
              context: context,
              cellAlignment: pw.Alignment.centerRight,
              data: const <List<String>>[
                <String>['   ', '  ', '   '],
                <String>['Taxable Amount', '  ', '400.00'],
                <String>['CGST@9%', '  ', '9.00'],
                <String>['SGST', ' ', '9.00'],
                <String>['Delivery Charge', '  ', '50.00'],
                <String>['Discount', '  ', '-10.00'],
                <String>['Grand Total', '  ', '458.00'],
                <String>['Advance', '  ', '-100.00'],
                <String>['Balance', '  ', '358.00'],
              ],
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

  File file = File("$documentPath/example.pdf");

  file.writeAsBytesSync(await pdf.save());
}

// onPressed: () async {
//  writeOnPdf();
//  await savePdf();
//
// Directory documentDirectory = await getApplicationDocumentsDirectory();
//
// String documentPath = documentDirectory.path;
//
// String fullPath = "$documentPath/example.pdf";
// print(fullPath);
// Navigator.push(context,
// MaterialPageRoute(
// builder: (context) => PdfPreviewScreen(
// path: fullPath,
// )));
// },
