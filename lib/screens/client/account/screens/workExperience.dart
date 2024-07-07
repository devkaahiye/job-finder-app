import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/screens/client/account/services/account_services.dart';
import '../../../../common/custom_textFormField.dart';
import '../../../../constants/appColors.dart';
import 'package:month_year_picker/month_year_picker.dart';

class WorkExperienceScreen extends StatefulWidget {
  static const String routeName = "/work-experience";
  const WorkExperienceScreen({super.key});

  @override
  State<WorkExperienceScreen> createState() => _WorkExperienceScreenState();
}

class _WorkExperienceScreenState extends State<WorkExperienceScreen> {
  var startSelectedDate = DateTime.now();
  var endSelectedDate = DateTime.now();
  var start = 'Start date';
  var end = 'End date';
  final _formkey = GlobalKey<FormState>();

  final AccountServices accountServices = AccountServices();

  TextEditingController companyNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController desController = TextEditingController();
  bool isSaving = false;
  bool currentlyWorking = false;
  String jobtitel = '';
  String jobcat = '';
  String employmetType = '';

  List<String> jobCategoriesList = [
    "Information Technology (IT)",
    "Healthcare",
    "Finance and Accounting",
    "Education",
    "Engineering",
    "Sales and Marketing",
    "Customer Service",
    "Human Resources (HR)",
    "Administration and Office Support",
    "Retail",
    "Hospitality and Tourism",
    "Manufacturing",
    "Construction",
    "Legal",
    "Media and Communications",
    "Design and Creative",
    "Consulting",
    "Research and Development (R&D)",
    "Science",
    "Transportation and Logistics",
  ];

  List<String> jobTitles = [
    "Software Engineer",
    "Registered Nurse",
    "Accountant",
    "Teacher",
    "Mechanical Engineer",
    "Sales Representative",
    "Marketing Manager",
    "Customer Service Representative",
    "Human Resources Manager",
    "Administrative Assistant",
    "Retail Sales Associate",
    "Hotel Front Desk Clerk",
    "Production Worker",
    "Construction Project Manager",
    "Attorney",
    "Journalist",
    "Graphic Designer",
    "Management Consultant",
    "Research Scientist",
    "Truck Driver",
    "Data Analyst",
    "Systems Administrator",
    "Web Developer",
    "Nurse Practitioner",
    "Financial Analyst",
    "School Principal",
    "Civil Engineer",
    "Account Manager",
    "Social Media Specialist",
    "Technical Support Specialist",
    "Inside Sales Representative",
    "Marketing Coordinator",
    "Executive Assistant",
    "Cashier",
    "Housekeeper",
    "lectrical Engineer",
    "Paralegal",
    "Content Writer",
    "Business Analyst",
    "Product Manager",
    "Pharmacist",
    "Operations Manager",
    "Customer Success Manager",
    "Receptionist",
    "Retail Store Manager",
    "Event Coordinator",
    "Software Developer",
    "Medical Assistant",
    "Quality Assurance Analyst",
    "Project Manager",
    "Dental Hygienist",
    "Supply Chain Manager",
    "IT Manager",
    "Occupational Therapist",
    "Public Relations Specialist",
    "UX/UI Designer",
    "Financial Advisor",
    "Human Resources Coordinator",
    "Sales Engineer",
    "Laboratory Technician",
  ];

  List<String> employmentTypeList = [
    "Full-time",
    "Part-time",
    "Internship",
    "Freelance",
    "Temporary",
    "Contract"
  ];

  void save() {
    setState(() {
      isSaving = true;
    });
    String formattedDate = startSelectedDate.toIso8601String();
    String formattedDate2 = endSelectedDate.toIso8601String();
    if (_formkey.currentState!.validate()) {
      accountServices.updateuserWorkExperience(
          context: context,
          title: jobtitel,
          category: jobcat,
          employmentType: employmetType,
          companyName: companyNameController.text,
          location: locationController.text,
          currentlyWorking: currentlyWorking,
          startDate: formattedDate,
          endDate: formattedDate2,
          description: desController.text,
          onError: () {
            setState(() {
              isSaving = false;
            });
          });
    }
  }

  @override
  void dispose() {
    companyNameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Experience'),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            SizedBox(height: size.height * 0.04),
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
                'Job Title',
                style: TextStyle(fontSize: 14),
              ),
              items: jobTitles
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
                  return 'Please select job title.';
                }
                return null;
              },
              onChanged: (value) {
                jobtitel = value.toString();
              },
              onSaved: (value) {
                jobtitel = value.toString();
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
                'Job Category',
                style: TextStyle(fontSize: 14),
              ),
              items: jobCategoriesList
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
                  return 'Please select job category.';
                }
                return null;
              },
              onChanged: (value) {
                jobcat = value.toString();
              },
              onSaved: (value) {
                jobcat = value.toString();
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
                'Employmet Type',
                style: TextStyle(fontSize: 14),
              ),
              items: employmentTypeList
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
                  return 'Please select employmet type.';
                }
                return null;
              },
              onChanged: (value) {
                employmetType = value.toString();
              },
              onSaved: (value) {
                employmetType = value.toString();
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
            const SizedBox(height: 20),
            CustomTextFormField(
                controller: companyNameController, hintText: 'Company Name'),
            const SizedBox(height: 20),
            CustomTextFormField(
                controller: locationController, hintText: 'Location'),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                    value: currentlyWorking,
                    onChanged: (val) {
                      setState(() {
                        currentlyWorking = val!;
                      });
                    }),
                const Text('i currently work in this role')
              ],
            ),
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
                        firstDate: DateTime(DateTime.now().year - 5),
                        lastDate: DateTime(DateTime.now().year + 5),
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
                        firstDate: DateTime(DateTime.now().year - 5),
                        lastDate: DateTime(DateTime.now().year + 5),
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
                controller: desController,
                hintText: 'Description...'),
            const SizedBox(height: 40),
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
