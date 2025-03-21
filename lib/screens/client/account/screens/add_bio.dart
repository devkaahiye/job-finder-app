import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/custom_textFormField.dart';
import '../../../../constants/appColors.dart';
import '../../../../provider/userProvider.dart';
import '../services/account_services.dart';

class AddBioScreen extends StatefulWidget {
  static const String routeName = '/add-bio';
  const AddBioScreen({super.key});

  @override
  State<AddBioScreen> createState() => _AddBioScreenState();
}

class _AddBioScreenState extends State<AddBioScreen> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController bioController = TextEditingController();
  bool isSaving = false;

  final AccountServices accountServices = AccountServices();

  void save() {
    setState(() {
      isSaving = true;
    });
    if (_formkey.currentState!.validate()) {
      accountServices.updateUserBio(
          context: context,
          bio: bioController.text,
          onError: () {
            setState(() {
              isSaving = false;
            });
          });
    }
  }

  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false).user;

    if (user.bio != "") {
      bioController.text = user.bio!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BIO'),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            CustomTextFormField(
                maxLines: 5,
                controller: bioController,
                hintText: 'Brief information about yourself...'),
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
