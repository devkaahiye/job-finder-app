import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:job_findder_app/models/category.dart';
import 'package:job_findder_app/screens/admin/category/services/categoryServices.dart';
import '../../../../common/custom_textFormField.dart';
import '../../../../constants/appColors.dart';

class UpdateCategoryScreen extends StatefulWidget {
  static const routeName = '/update-category';
  final Category category;

  const UpdateCategoryScreen({super.key, required this.category});

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final CategoryServices categoryServices = CategoryServices();

  bool isSaving = false;
  TextEditingController namecontroller = TextEditingController();

  void update() {
    setState(() {
      isSaving = true;
    });
    categoryServices.update(
        context: context,
        id: widget.category.id,
        name: namecontroller.text,
        onError: () {
          setState(() {
            isSaving = false;
          });
        });
  }

  @override
  void initState() {
    namecontroller.text = widget.category.name;
    super.initState();
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
        title: const Text('Update Category'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(height: size.height * 0.03),
          CustomTextFormField(
              controller: namecontroller, hintText: 'Category Name'),
          SizedBox(height: size.height * 0.03),
        ],
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
                onPressed: update,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
    );
  }
}
