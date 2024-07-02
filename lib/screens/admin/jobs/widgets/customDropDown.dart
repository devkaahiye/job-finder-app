import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '/models/category.dart';
import '/models/subCategories.dart';

class CustomDropDown extends StatelessWidget {
  final List<Category>? categories;
  final List<SubCategory>? subcategories;
  String hintText;
  final Function(String) onSelectedValue;
  CustomDropDown(
      {super.key,
      this.categories,
      this.subcategories,
      required this.hintText,
      required this.onSelectedValue});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      hint: Text(
        hintText,
        style: const TextStyle(fontSize: 14),
      ),
      items: categories != null
          ? categories!
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item.id,
                  child: Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )
              .toList()
          : subcategories!
              .map((item) => DropdownMenuItem<String>(
                    value: item.id,
                    child: Text(
                      item.name,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal),
                    ),
                  ))
              .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select job ${categories == null ? 'subcategory' : 'category'}.';
        }
        return null;
      },
      onChanged: (value) {
        if (value != null) {
          onSelectedValue(value.toString());
        }
      },
      onSaved: (value) {
        if (value != null) {
          onSelectedValue(value.toString());
        }
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
