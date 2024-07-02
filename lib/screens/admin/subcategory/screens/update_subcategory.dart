import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:job_findder_app/models/category.dart';
import 'package:job_findder_app/models/subCategories.dart';
import 'package:job_findder_app/screens/admin/category/services/categoryServices.dart';
import '../../../../common/custom_textFormField.dart';
import '../../../../constants/global_variables.dart';
import '../services/subcategoryServices.dart';

class UpdateSubCategoryScreen extends StatefulWidget {
  static const routeName = '/update-subcategory';
  final SubCategory subCategory;

  const UpdateSubCategoryScreen({super.key, required this.subCategory});

  @override
  State<UpdateSubCategoryScreen> createState() =>
      _UpdateSubCategoryScreenState();
}

class _UpdateSubCategoryScreenState extends State<UpdateSubCategoryScreen> {
  final SubCategoryServices subCategoryServices = SubCategoryServices();
  final CategoryServices categoryServices = CategoryServices();
  bool isSaving = false;
  TextEditingController namecontroller = TextEditingController();
  List<Category> categriesList = [];

  var selectedCategory;
  var selectedCategoryName;
  bool isLoading = true;

  void save() {
    setState(() {
      isSaving = true;
    });
    subCategoryServices.update(
        context: context,
        id: widget.subCategory.id,
        name: namecontroller.text,
        category: selectedCategory,
        onError: () {
          setState(() {
            isSaving = false;
          });
        });
  }

  void loadCategories() async {
    categriesList = await categoryServices.getCategories(context: context);
    isLoading = false;
    if (context.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    loadCategories();
    namecontroller.text = widget.subCategory.name;
    selectedCategoryName = widget.subCategory.category["name"];
    selectedCategory = widget.subCategory.category["_id"];
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
        title: const Text('Update SubCategory'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(height: size.height * 0.03),
          CustomTextFormField(
              controller: namecontroller, hintText: 'SubCategory'),
          SizedBox(height: size.height * 0.03),
          Text("Current Category: $selectedCategoryName"),
          SizedBox(height: size.height * 0.03),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : categriesList.isEmpty
                  ? const Text("Create Category First!")
                  : DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        // Add Horizontal padding using menuItemStyleData.padding so it matches
                        // the menu padding when button's width is not specified.
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        // Add more decoration..
                      ),
                      hint: const Text(
                        'Update job category',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: categriesList
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
                          return 'Please select your category.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        selectedCategory = value.toString();
                        for (var element in categriesList) {
                          if (element.id == selectedCategory) {
                            selectedCategoryName = element.name;
                          }
                        }
                        setState(() {});
                      },
                      onSaved: (value) {
                        selectedCategory = value.toString();
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
          SizedBox(height: size.height * 0.03),
        ],
      ),
      bottomNavigationBar: isSaving
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalVariables.primarycolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: save,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
    );
  }
}
