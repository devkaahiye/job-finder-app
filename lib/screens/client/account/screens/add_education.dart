import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../../../../common/custom_textFormField.dart';
import '../../../../constants/appColors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../services/account_services.dart';

class AddEducationScreen extends StatefulWidget {
  static const String routeName = '/add-education';

  const AddEducationScreen({super.key});

  @override
  State<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  final AccountServices accountServices = AccountServices();
  var startSelectedDate = DateTime.now();
  var endSelectedDate = DateTime.now();
  final _formkey = GlobalKey<FormState>();

  var start = 'Start date';
  var end = 'End date';

  TextEditingController schoolController = TextEditingController();
  TextEditingController fieldOfStudycontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();

  bool isSaving = false;
  var selectedValue = '';

  List<String> degreeList = [
    'Primary School',
    'Secondary School',
    'Diploma',
    'Higher Diploma',
    'Bachelor Degree',
    'Master Degree',
    'Doctorate',
  ];

  void save() {
    setState(() {
      isSaving = true;
    });
    String formattedDate = startSelectedDate.toIso8601String();
    String formattedDate2 = endSelectedDate.toIso8601String();
    if (_formkey.currentState!.validate()) {
      accountServices.updateUserEducation(
          context: context,
          school: schoolController.text,
          degree: selectedValue,
          fieldOfStudy: fieldOfStudycontroller.text,
          description: descontroller.text,
          startDate: formattedDate,
          endDate: formattedDate2,
          onError: () {
            setState(() {
              isSaving = false;
            });
          });
    }
  }

  @override
  void dispose() {
    schoolController.dispose();
    fieldOfStudycontroller.dispose();
    descontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education'),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            SizedBox(height: size.height * 0.04),
            CustomTextFormField(
                controller: schoolController, hintText: 'School or University'),
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
                'Select Your Degree',
                style: TextStyle(fontSize: 14),
              ),
              items: degreeList
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
                  return 'Please select your degree.';
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
            SizedBox(height: size.height * 0.04),
            TextFField(
                controller: fieldOfStudycontroller, hintText: 'Field of study'),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black54)),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black54,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () async {
                      final DateTime? picked = await showMonthYearPicker(
                        context: context,
                        initialDate: startSelectedDate,
                        firstDate: DateTime(DateTime.now().year - 50),
                        lastDate: DateTime(DateTime.now().year + 50),
                      );
                      if (picked != null) {
                        setState(() {
                          startSelectedDate = picked;
                          start =
                              '${startSelectedDate.month}/${startSelectedDate.year}';
                        });
                      }
                    },
                    child: Text(start),
                  ),
                )),
                const SizedBox(width: 20),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black54)),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black54,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () async {
                      final DateTime? picked = await showMonthYearPicker(
                        context: context,
                        initialDate: endSelectedDate,
                        firstDate: DateTime(DateTime.now().year - 50),
                        lastDate: DateTime(DateTime.now().year + 50),
                      );
                      if (picked != null) {
                        setState(() {
                          endSelectedDate = picked;
                          end =
                              '${endSelectedDate.month}/${endSelectedDate.year}';
                        });
                      }
                    },
                    child: Text(end),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
                maxLines: 5,
                controller: descontroller,
                hintText: 'Description...'),
          ],
        ),
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
