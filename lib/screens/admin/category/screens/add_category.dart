import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:job_findder_app/screens/admin/category/screens/categories.dart';
import 'package:job_findder_app/screens/admin/category/services/categoryServices.dart';
import '../../../../common/custom_textFormField.dart';
import '../../../../constants/appColors.dart';

class AddCategoryScreen extends StatefulWidget {
  static const routeName = '/add-category';

  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final CategoryServices categoryServices = CategoryServices();

  bool isSaving = false;
  TextEditingController namecontroller = TextEditingController();

  void save() {
    setState(() {
      isSaving = true;
    });
    categoryServices.save(
        context: context,
        name: namecontroller.text,
        onError: () {
          setState(() {
            isSaving = false;
          });
        });
  }

  @override
  void dispose() {
    namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Category'),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            SizedBox(height: size.height * 0.03),
            CustomTextFormField(
                controller: namecontroller, hintText: 'Category Name'),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
      bottomNavigationBar: isSaving
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarycolor,
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
