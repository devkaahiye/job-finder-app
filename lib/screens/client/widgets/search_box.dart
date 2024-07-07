import 'package:flutter/material.dart';
import 'package:job_findder_app/constants/appColors.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_rounded)),
            hintText: "Search a job or position",
          ),
        ),
      ),
    );
  }
}
