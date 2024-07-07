import 'package:flutter/material.dart';
import '/screens/admin/category/screens/categories.dart';
import '/screens/admin/jobs/screens/jobs_screen.dart';
import '/screens/admin/subcategory/screens/subcategories.dart';
import '/screens/admin/users/screens/adminUsersList.dart';
import '/screens/admin/users/screens/usersList.dart';
import '/screens/auth/screens/login.dart';
import 'package:provider/provider.dart';

import '../../../constants/appColors.dart';
import '../../../provider/userProvider.dart';
import '../../auth/services/auth_services.dart';

class NavigatorDDrawer extends StatelessWidget {
  const NavigatorDDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
              child: const CircleAvatar(
                radius: 30,
                child: Icon(Icons.person),
              ),
            ),
            title: Text(
              userProvider.name,
              style: const TextStyle(color: Colors.black87, fontSize: 18),
            ),
            subtitle: Text(
              userProvider.email,
              style: const TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            onTap: () =>
                Navigator.pushNamed(context, CategoriesScreen.routeName),
            title: const Text(
              'Categories',
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
            leading: const Icon(Icons.category,
                color: AppColors.secondaryColor),
          ),
          ListTile(
            onTap: () =>
                Navigator.pushNamed(context, SubcategoriesScreen.routeName),
            title: const Text(
              'SubCategories',
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
            leading: const Icon(Icons.category,
                color: AppColors.secondaryColor),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, JobsScreen.routeName),
            title: const Text(
              'Jobs',
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
            leading:
                const Icon(Icons.school, color: AppColors.secondaryColor),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, UserListScreen.routeName),
            title: const Text(
              'Job Seekers',
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
            leading: const Icon(Icons.groups_3_rounded,
                color: AppColors.secondaryColor),
          ),
          ListTile(
            onTap: () =>
                Navigator.pushNamed(context, AdminUsersScreen.routeName),
            title: const Text(
              'Users',
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
            leading:
                const Icon(Icons.group, color: AppColors.secondaryColor),
          ),
          ListTile(
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                        title: const Text('LogOut'),
                        content: const Text("Are you sure to log out?"),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Cancel")),
                          TextButton(
                              onPressed: () => AuthService().logOut(context),
                              child: const Text("Yes"))
                        ])),
            title: const Text(
              'LogOut',
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
            leading:
                const Icon(Icons.logout, color: AppColors.secondaryColor),
          )
        ],
      ),
    );
  }
}
