import 'package:flutter/material.dart';
import 'package:job_findder_app/common/custom_Alertdailog.dart';
import 'package:job_findder_app/screens/admin/category/screens/update_category.dart';
import 'package:job_findder_app/screens/admin/subcategory/screens/add_subcategory.dart';
import 'package:job_findder_app/screens/admin/subcategory/services/subcategoryServices.dart';

import '../../../../constants/global_variables.dart';
import '../../../../constants/utils.dart';
import '../../../../models/subCategories.dart';
import 'update_subcategory.dart';

class SubcategoriesScreen extends StatefulWidget {
  static const routeName = '/subcategory';

  const SubcategoriesScreen({super.key});

  @override
  State<SubcategoriesScreen> createState() => _SubcategoriesScreenState();
}

class _SubcategoriesScreenState extends State<SubcategoriesScreen> {
  List<SubCategory> subcategriesList = [];
  bool isLoading = true;
  final SubCategoryServices subCategoryServices = SubCategoryServices();

  void loadSubCategories() async {
    subcategriesList =
        await subCategoryServices.getSubCategories(context: context);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void deleteSubCategories(String id, int index) {
    subCategoryServices.delete(
        id: id,
        onSucc: () {
          subcategriesList.removeAt(index);
          showSnackBar(context, 'Deleted Successfully');
          setState(() {});
        },
        context: context);
  }

  void _navigateToAddSubCategory() async {
    var res =
        await Navigator.pushNamed(context, AddSubCategoryScreen.routeName);

    if (res == "refresh") {
      loadSubCategories();
    }
  }

  void _navigateToUpdateSubCategory(SubCategory subCategory) async {
    var res = await Navigator.pushNamed(
        context, UpdateSubCategoryScreen.routeName,
        arguments: subCategory);

    if (res == "refresh") {
      loadSubCategories();
    }
  }

  @override
  void initState() {
    loadSubCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubCategories'),
        actions: [
          IconButton(
              onPressed: _navigateToAddSubCategory,
              icon: const Icon(
                Icons.add_circle,
                color: GlobalVariables.secondaryColor,
              ))
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : subcategriesList.isEmpty
              ? const Center(child: Text("SubCategories not found"))
              : ListView.builder(
                  itemCount: subcategriesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var subcategory = subcategriesList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(subcategory.name),
                          subtitle: Text(subcategory.category != ''
                              ? subcategory.category["name"]
                              : 'Not Found'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      _navigateToUpdateSubCategory(subcategory),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CustomAlertDailog(onTab: () {
                                            Navigator.of(context).pop();
                                            deleteSubCategories(
                                                subcategory.id, index);
                                          })),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
