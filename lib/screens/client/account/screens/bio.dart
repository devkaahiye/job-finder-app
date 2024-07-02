import 'package:flutter/material.dart';

import '../../../../common/custom_textFormField.dart';
import '../../../../constants/global_variables.dart';
import '../services/account_services.dart';

class BioScreen extends StatefulWidget {
  static const String routeName = '/bio';
  const BioScreen({super.key});

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
