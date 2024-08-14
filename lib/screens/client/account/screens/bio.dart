import 'package:flutter/material.dart';
import 'package:job_findder_app/screens/client/account/screens/add_bio.dart';
import 'package:provider/provider.dart';

import '../../../../common/custom_textFormField.dart';
import '../../../../constants/appColors.dart';
import '../../../../provider/userProvider.dart';
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
    var user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BIO'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(
            height: size.height * 0.04,
          ),
          Text("${user.bio}")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(AddBioScreen.routeName),
        child: Icon(Icons.edit),
      ),
    );
  }
}
