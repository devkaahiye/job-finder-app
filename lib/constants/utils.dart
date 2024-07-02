import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(text),
      margin: const EdgeInsets.all(16.0),
    ),
  );
}

Future<File?> pickImage() async {
  File? image;
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        image = File(files.files[0].path!);
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return image;
}
