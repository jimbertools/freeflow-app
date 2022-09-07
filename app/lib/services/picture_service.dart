import 'dart:convert';
import 'dart:typed_data';

import 'package:app/screens/scan_qr_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

Future<String> pickImage() async {
  PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery) as PickedFile;
  Uint8List imageBytes = await image.readAsBytes();
  String b64EncodedImage = base64Encode(imageBytes);
  return b64EncodedImage;
}

Future<String> takeImage() async {
  PickedFile image = await ImagePicker().getImage(source: ImageSource.camera) as PickedFile;
  Uint8List imageBytes = await image.readAsBytes();
  String b64EncodedImage = base64Encode(imageBytes);
  return b64EncodedImage;
}


Future<dynamic> scanQRCode(BuildContext context) async{
  await SystemChannels.textInput.invokeMethod('TextInput.hide');

  // QRCode scanner is black if we don't sleep here.
  bool slept = await Future.delayed(const Duration(milliseconds: 400), () => true);

  Barcode? result;
  if (slept) {
    result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ScanScreen()));
  }

  return result?.code;
}