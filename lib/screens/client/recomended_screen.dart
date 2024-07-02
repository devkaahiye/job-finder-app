import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:job_findder_app/constants/utils.dart';
import 'package:job_findder_app/provider/userProvider.dart';
import 'package:job_findder_app/screens/client/services/client_services.dart';
import 'package:provider/provider.dart';

import '../../constants/global_variables.dart';
import '../../models/category.dart';
import '../admin/category/services/categoryServices.dart';

class RecomendedJobsScreen extends StatefulWidget {
  static const String routeName = '/recomended';
  const RecomendedJobsScreen({super.key});

  @override
  State<RecomendedJobsScreen> createState() => _RecomendedJobsScreenState();
}

class _RecomendedJobsScreenState extends State<RecomendedJobsScreen> {
  List<Category> categriesList = [];
  List<String> selectedCategriesList = [];
  bool isLoading = true;
  bool isSaving = false;
  final CategoryServices categoryServices = CategoryServices();
  final ClientServices _clientServices = ClientServices();

  void loadCategories() async {
    categriesList = await categoryServices.getCategories(context: context);
    isLoading = false;
    if (context.mounted) {
      setState(() {});
    }
  }

  void save() {
    setState(() {
      isSaving = true;
    });
    _clientServices.add(
        categories: selectedCategriesList,
        context: context,
        onError: () {
          setState(() {
            isSaving = false;
          });
        });
  }

  @override
  void initState() {
    loadCategories();
    super.initState();
  }

  void addToList(String categoryId) {
    bool exists = false;
    if (selectedCategriesList.isEmpty) {
      selectedCategriesList.add(categoryId.toString());
    } else {
      if (selectedCategriesList.length >= 3) {
        return showSnackBar(context, 'Choose at least 3 categories only');
      } else {
        for (var i = 0; i < selectedCategriesList.length; i++) {
          if (selectedCategriesList[i] == categoryId) {
            exists = true;
          }
        }

        if (exists) {
          selectedCategriesList.remove(categoryId.toString());
        } else {
          selectedCategriesList.add(categoryId.toString());
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<UserProvider>(context).user.categories;

    if (categories != null) {
      for (var element in categories) {
        print(element);
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Discover your \ndream job',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: GlobalVariables.primarycolor),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Choose at least 3 categories:',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: GlobalVariables.primarycolor),
                ),
              ),
              Flexible(
                child: isLoading
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: 9,
                        itemBuilder: (BuildContext context, int index) {
                          return const CardLoading(
                            height: 50,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          );
                        },
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: categriesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var category = categriesList[index];

                          return GestureDetector(
                            onTap: () => addToList(category.id),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: selectedCategriesList
                                              .contains(category.id)
                                          ? GlobalVariables.paradisePink
                                          : Colors.transparent),
                                  color: GlobalVariables.backgroundColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text(category.name)),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: isSaving
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: GlobalVariables.secondaryColor,
                      foregroundColor: Colors.white),
                  onPressed: save,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  )),
            ),
    );
  }
}
