import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';

class CustomTextField2 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  const CustomTextField2(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: GlobalVariables.primarycolor),
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is required!';
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 0.01),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide:
                const BorderSide(color: GlobalVariables.secondaryColor)),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        fillColor: Colors.white,
        prefixIcon: Icon(
          icon,
          color: GlobalVariables.secondaryColor,
        ),
      ),
    );
  }
}
