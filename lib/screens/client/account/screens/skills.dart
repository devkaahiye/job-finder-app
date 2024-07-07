import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '/screens/client/account/services/account_services.dart';

import '../../../../common/custom_textFormField.dart';
import '../../../../constants/appColors.dart';

class SkillsScreen extends StatefulWidget {
  static const String routeName = '/skills';
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  TextEditingController controller = TextEditingController();
  AccountServices accountServices = AccountServices();
  bool isSaving = false;
  var selectedValue = '';

  List<String> levelsList = [
    'Beginner',
    'Intermediate',
    'Expert',
  ];

  void save() {
    setState(() {
      isSaving = true;
    });
    accountServices.updateUserSkills(
        context: context,
        skill: controller.text,
        level: selectedValue,
        onError: () {
          setState(() {
            isSaving = false;
          });
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(height: size.height * 0.04),
          CustomTextFormField(controller: controller, hintText: 'Skill'),
          const SizedBox(height: 20),
          DropdownButtonFormField2<String>(
            isExpanded: true,
            decoration: InputDecoration(
              // Add Horizontal padding using menuItemStyleData.padding so it matches
              // the menu padding when button's width is not specified.
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              // Add more decoration..
            ),
            hint: const Text(
              'Select Your Level',
              style: TextStyle(fontSize: 14),
            ),
            items: levelsList
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.normal),
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select your level.';
              }
              return null;
            },
            onChanged: (value) {
              selectedValue = value.toString();
            },
            onSaved: (value) {
              selectedValue = value.toString();
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
          ),
        ],
      ),
      bottomNavigationBar: isSaving
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: save,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
    );
  }
}

class TextFField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final TextInputType textInputType;
  const TextFField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {}, icon: const Icon(Icons.arrow_drop_down)),
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
