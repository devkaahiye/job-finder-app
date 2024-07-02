import 'package:flutter/material.dart';
import 'package:job_findder_app/constants/global_variables.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: GlobalVariables.greyBackgroundCOlor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: GlobalVariables.greyBackgroundCOlor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: GlobalVariables.greyBackgroundCOlor)),
        prefixIcon: IconButton(
            onPressed: () {}, icon: const Icon(Icons.search_rounded)),
        filled: true,
        fillColor: Colors.grey.shade300,
        hintText: "Search a job or position",
      ),
    );
  }
}
