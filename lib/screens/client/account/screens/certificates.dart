import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_findder_app/screens/client/account/services/account_services.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../../common/custom_textFormField.dart';
import '../../../../constants/global_variables.dart';

class CertificateScreen extends StatefulWidget {
  static const String routeName = '/certificate';
  const CertificateScreen({super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController issuingOrgcontroller = TextEditingController();
  TextEditingController issuingDatecontroller = TextEditingController();
  TextEditingController certificateUrlController = TextEditingController();
  TextEditingController descontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isSaving = false;
  var selectedDate = 'Issue date';
  var selectedDateTime = DateTime.now();

  AccountServices accountServices = AccountServices();

  void save() {
    setState(() {
      isSaving = true;
    });
    String formattedDate = selectedDateTime.toIso8601String();
    if (_formkey.currentState!.validate()) {
      accountServices.updateUserCertificates(
          context: context,
          title: titleController.text,
          organization: issuingOrgcontroller.text,
          issueDate: formattedDate,
          certificateUrl:
              "https://as2.ftcdn.net/v2/jpg/02/01/82/51/1000_F_201825112_dm1tHvITOxrZf7tA1lCSLLytD3ppx0nQ.jpg",
          description: descontroller.text,
          onError: () {
            setState(() {
              isSaving = false;
            });
          });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    issuingOrgcontroller.dispose();
    issuingDatecontroller.dispose();
    certificateUrlController.dispose();
    descontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Certificate'),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            SizedBox(height: size.height * 0.04),
            CustomTextFormField(controller: titleController, hintText: 'Title'),
            const SizedBox(height: 20),
            CustomTextFormField(
                controller: issuingOrgcontroller,
                hintText: 'Issuing Organization'),
            const SizedBox(height: 20),
            Container(
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
                    initialDate: selectedDateTime,
                    firstDate: DateTime(DateTime.now().year - 5),
                    lastDate: DateTime(DateTime.now().year + 5),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDateTime = picked;
                      var sdate = selectedDateTime.toString().substring(0, 10);
                      var ssDate = DateTime.parse(sdate);
                      selectedDate = DateFormat.yMMMM('en_US').format(ssDate);
                    });
                  }
                },
                child: Text(selectedDate),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
                controller: certificateUrlController,
                hintText: 'Certificate Url'),
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
                    backgroundColor: GlobalVariables.secondaryColor,
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
