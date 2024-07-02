import 'package:card_loading/card_loading.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:job_findder_app/models/jobs.dart';
import 'package:job_findder_app/screens/admin/jobs/services/jobServices.dart';
import '/screens/admin/jobs/widgets/customDropDown.dart';

import '../../../../common/custom_textFormField.dart';
import '../../../../constants/global_variables.dart';
import '../../../../models/category.dart';
import '../../../../models/subCategories.dart';
import '../../category/services/categoryServices.dart';
import '../../subcategory/services/subcategoryServices.dart';

class AddJobsScreen extends StatefulWidget {
  static const routeName = '/add-job';
  const AddJobsScreen({super.key});

  @override
  State<AddJobsScreen> createState() => _AddJobsScreenState();
}

class _AddJobsScreenState extends State<AddJobsScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController respoController = TextEditingController();
  final TextEditingController quaController = TextEditingController();
  final TextEditingController expController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController jobTypeController = TextEditingController();
  final TextEditingController companyUrlController = TextEditingController();
  final TextEditingController jobOverviewController = TextEditingController();

  final CategoryServices categoryServices = CategoryServices();
  final SubCategoryServices subCategoryServices = SubCategoryServices();
  final JobServices _jobServices = JobServices();

  bool isSaving = false;
  var _formKey = GlobalKey<FormState>();
  String selectedCatValue = "";
  String selectedSubValue = "";
  List<Category> categories = [];

  String countryValue = '';
  String stateValue = '';
  String cityValue = '';

  bool isLoadingCat = true;
  bool isLoadingSub = true;
  List<SubCategory> subcategriesList = [];

  void loadCategories() async {
    categories = await categoryServices.getCategories(context: context);
    isLoadingCat = false;
    if (context.mounted) {
      setState(() {});
    }
  }

  void loadSubCategories() async {
    subcategriesList =
        await subCategoryServices.getSubCategories(context: context);
    isLoadingSub = false;
    if (context.mounted) {
      setState(() {});
    }
  }

  void save() {
    List<String> responsibilities = [];
    List<String> qualifications = [];
    List<String> experienceRequirements = [];

    responsibilities = respoController.text.split(',');
    qualifications = quaController.text.split(',');
    experienceRequirements = expController.text.split(',');

    if (_formKey.currentState!.validate()) {
      setState(() {
        isSaving = true;
      });
      _jobServices.save(
          category: selectedCatValue,
          subcategory: selectedSubValue,
          job: Job(
              title: titleController.text,
              company: companyNameController.text,
              city: cityValue,
              state: stateValue,
              country: countryValue,
              description: descriptionController.text,
              responsibilities: responsibilities,
              qualifications: qualifications,
              salary: int.parse(salaryController.text),
              companyLogoUrl: companyUrlController.text,
              experienceRequirements: experienceRequirements,
              jobOverview: jobOverviewController.text,
              jobType: jobTypeController.text),
          context: context,
          onError: () {
            setState(() {
              isSaving = false;
            });
          });
    }
  }

  @override
  void initState() {
    loadCategories();
    loadSubCategories();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    companyNameController.dispose();
    companyUrlController.dispose();
    jobOverviewController.dispose();
    jobTypeController.dispose();
    salaryController.dispose();
    descriptionController.dispose();
    respoController.dispose();
    quaController.dispose();
    expController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new job'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextFormField(
              controller: titleController,
              hintText: 'Job Title',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            isLoadingCat
                ? const CardLoading(
                    height: 60,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
                : CustomDropDown(
                    categories: categories,
                    hintText: 'Select Job Category',
                    onSelectedValue: (value) {
                      setState(() {
                        selectedCatValue = value;
                      });
                    },
                  ),
            SizedBox(
              height: size.height * 0.02,
            ),
            isLoadingSub
                ? const CardLoading(
                    height: 60,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
                : CustomDropDown(
                    subcategories: subcategriesList,
                    hintText: 'Select job SubCatgory',
                    onSelectedValue: (value) {
                      setState(() {
                        selectedSubValue = value;
                      });
                    },
                  ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextFormField(
              controller: companyNameController,
              hintText: 'Company Name',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            _buildStatePicker(),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextFormField(
              controller: descriptionController,
              maxLines: 6,
              hintText: 'Description',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextFormField(
              controller: respoController,
              maxLines: 6,
              hintText: 'Responsibilities (use comma to separate)',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextFormField(
              controller: quaController,
              maxLines: 6,
              hintText: 'Qualifications (use comma to separate)',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextFormField(
              controller: expController,
              maxLines: 6,
              hintText: 'Experiences (use comma to separate)',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextFormField(
              controller: salaryController,
              textInputType: TextInputType.number,
              hintText: 'Salary',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextFormField(
              controller: jobTypeController,
              hintText: 'JobType (full time or part time)',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextFormField(
              controller: companyUrlController,
              hintText: 'Company LogoUrl',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextFormField(
              controller: jobOverviewController,
              maxLines: 4,
              hintText: 'Job Overview',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
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

  CSCPicker _buildStatePicker() {
    return CSCPicker(
      showStates: true,
      showCities: true,
      flagState: CountryFlag.ENABLE,
      dropdownDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1)),
      disabledDropdownDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.grey.shade300, width: 1)),
      countrySearchPlaceholder: "Country",
      stateSearchPlaceholder: "State",
      citySearchPlaceholder: "City",
      countryDropdownLabel: "*Country",
      stateDropdownLabel: "*State",
      cityDropdownLabel: "*City",
      selectedItemStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      dropdownHeadingStyle: const TextStyle(
          color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
      dropdownItemStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      dropdownDialogRadius: 10.0,
      searchBarRadius: 10.0,
      onCountryChanged: (value) {
        setState(() {
          countryValue = value;
        });
      },
      onStateChanged: (value) {
        if (value != null) {
          setState(() {
            stateValue = value;
          });
        }
      },
      onCityChanged: (value) {
        if (value != null) {
          setState(() {
            cityValue = value;
          });
        }
      },
    );
  }
}
