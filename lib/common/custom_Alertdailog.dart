import 'package:flutter/material.dart';

class CustomAlertDailog extends StatelessWidget {
  final VoidCallback onTab;
  const CustomAlertDailog({super.key, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete"),
      content: const Text("Are you sure you want to delete?"),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No")),
        TextButton(onPressed: onTab, child: const Text("Yes"))
      ],
    );
  }
}
