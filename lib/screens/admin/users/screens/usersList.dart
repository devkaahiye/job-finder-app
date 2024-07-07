import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_findder_app/screens/admin/users/services/adminUserServices.dart';

import '../../../../common/custom_textField.dart';
import '../../../../constants/appColors.dart';
import '../../../../models/userModel.dart';

class UserListScreen extends StatefulWidget {
  static const String routeName = '/userslist';
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserreenListScreenState();
}

class _UserreenListScreenState extends State<UserListScreen> {
  TextEditingController controller = TextEditingController();
  final AdminUserServices _adminUserServices = AdminUserServices();
  List<User> usersList = [];
  bool isLoading = true;

  void getAllUsers() async {
    usersList = await _adminUserServices.getAllUsers(context: context);
    isLoading = false;
    if (context.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Seekers(${usersList.length})'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextField(
                controller: controller, hintText: 'Search user by name'),
            const SizedBox(height: 10),
            isLoading
                ? Flexible(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CardLoading(
                            height: 100,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        );
                      },
                    ),
                  )
                : Flexible(
                    child: ListView.builder(
                      itemCount: usersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var user = usersList[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.greyBackgroundCOlor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    'Name: ${user.name}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email: ${user.email}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Phone: ${user.phone}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Bio: ${user.bio}',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
