import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:job_findder_app/constants/global_variables.dart';
import 'package:job_findder_app/screens/admin/category/screens/add_category.dart';
import 'package:job_findder_app/screens/admin/category/screens/update_category.dart';
import 'package:job_findder_app/screens/admin/category/services/categoryServices.dart';

import '../../../../common/custom_Alertdailog.dart';
import '../../../../constants/utils.dart';
import '../../../../models/category.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/categories';

  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> categriesList = [];
  bool isLoading = true;
  final CategoryServices categoryServices = CategoryServices();

  void loadCategories() async {
    categriesList = await categoryServices.getCategories(context: context);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    loadCategories();
    super.initState();
  }

  void _navigateToAddCategory() async {
    var res = await Navigator.pushNamed(context, AddCategoryScreen.routeName);

    if (res == "refresh") {
      loadCategories();
    }
  }

  void _navigateToUpdateCategory(Category category) async {
    var res = await Navigator.pushNamed(context, UpdateCategoryScreen.routeName,
        arguments: category);

    if (res == "refresh") {
      loadCategories();
    }
  }

  void deleteCategories({required String id, required int index}) {
    categoryServices.delete(
        id: id,
        onSucc: () {
          categriesList.removeAt(index);
          showSnackBar(context, 'Deleted Successfully');
          setState(() {});
        },
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
              onPressed: _navigateToAddCategory,
              icon: const Icon(
                Icons.add_circle,
                color: GlobalVariables.secondaryColor,
              ))
        ],
      ),
      body: isLoading
          ? ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return const CardLoading(
                  height: 100,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                );
              })
          : ListView.builder(
              itemCount: categriesList.length,
              itemBuilder: (BuildContext context, int index) {
                var category = categriesList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(category.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () =>
                                  _navigateToUpdateCategory(category),
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
                                        deleteCategories(
                                            id: category.id, index: index);
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
