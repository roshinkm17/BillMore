import 'package:flutter/material.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String path;

  PdfPreviewScreen({this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: PdfPreviewScreen(
        path: path,
      ),
    );
  }
}
