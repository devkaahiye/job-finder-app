import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/common/custom_textFormField.dart';
import '/models/userModel.dart';

import '../../../../constants/appColors.dart';

class UpdateProfileScreen extends StatefulWidget {
  final User user;
  static const String routeName = '/update-profile';
  const UpdateProfileScreen({super.key, required this.user});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmpasswordController =
      TextEditingController();

  bool isUpdating = false;
  bool isMale = false;
  String sex = '';

  Country selectedCountry = Country(
    phoneCode: "252",
    countryCode: "SO",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "so",
    example: "so",
    displayName: "Somalia",
    displayNameNoCountryCode: "Somalia (SO)",
    e164Key: "",
  );

  void update() {}

  @override
  void initState() {
    nameController.text = widget.user.name;
    phoneController.text = widget.user.phone;
    cityController.text = widget.user.city;
    print(widget.user.sex);

    if (widget.user.sex == 'Male') {
      isMale = true;
    } else {
      isMale = false;
    }
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: size.height * 0.02),
          CustomTextFormField(
              controller: nameController, hintText: 'Enter your name'),
          SizedBox(height: size.height * 0.02),
          CustomTextFormField(
              controller: phoneController, hintText: 'Enter your phone'),
          SizedBox(height: size.height * 0.02),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                    controller: cityController, hintText: 'Enter your city'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white),
                  child: TextButton(
                    style: TextButton.styleFrom(alignment: Alignment.topLeft),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        '${selectedCountry.flagEmoji} ${selectedCountry.displayNameNoCountryCode}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    onPressed: () {
                      showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            bottomSheetHeight: size.height * 0.6,
                          ),
                          onSelect: (value) {
                            setState(() {
                              selectedCountry = value;
                            });
                          });
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: size.height * 0.02),
          _buildSexOptions(),
          SizedBox(height: size.height * 0.02),
          CustomTextFormField(
              controller: passwordController,
              hintText: 'New password(optional)'),
          SizedBox(height: size.height * 0.02),
          CustomTextFormField(
              controller: comfirmpasswordController,
              hintText: 'Confirm new password(optional)'),
        ],
      ),
      bottomNavigationBar: isUpdating
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
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

  Container _buildSexOptions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Sex:'),
          Row(
            children: [
              Row(
                children: [
                  Checkbox(
                      value: isMale,
                      onChanged: (val) {
                        setState(() {
                          isMale = true;
                          if (isMale == true) {
                            sex = 'Male';
                          } else {
                            sex = 'Female';
                          }
                        });
                      }),
                  const Text('Male')
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: isMale,
                      onChanged: (val) {
                        setState(() {
                          isMale = false;
                          if (isMale == true) {
                            sex = 'Male';
                          } else {
                            sex = 'Female';
                          }
                        });
                      }),
                  const Text('Female')
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
