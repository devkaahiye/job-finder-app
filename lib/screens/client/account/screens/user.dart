import 'package:flutter/material.dart';
import 'package:job_findder_app/screens/client/account/screens/add_bio.dart';
import 'package:job_findder_app/screens/client/recomended_screen.dart';
import '/screens/client/account/screens/bio.dart';
import '/screens/client/account/screens/certificates.dart';
import '/screens/client/account/screens/education.dart';
import '/screens/client/account/screens/languages.dart';
import '/screens/client/account/screens/skills.dart';
import '/screens/client/account/screens/update_profile_screen.dart';
import '/screens/client/account/screens/workExperience.dart';
import 'package:provider/provider.dart';
import '../../../../provider/userProvider.dart';
import '../../../auth/screens/login.dart';
import '../widgets/iconWidget.dart';
import '../widgets/profile.dart';
import '../widgets/workExperienceWidget.dart';
import '../../../auth/services/auth_services.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/account';
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = context.watch<UserProvider>().user;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: ProfileWidget(
                    name: user.name,
                    email: user.email,
                    onPressed: () => Navigator.of(context).pushNamed(
                        UpdateProfileScreen.routeName,
                        arguments: user)),
              ),
              Expanded(
                  child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    IconWidget(
                        text: 'BIO',
                        text2: user.bio == ""
                            ? 'Brief information about yourself.'
                            : "${user.bio}",
                        iconData: Icons.person,
                        iconColor: user.bio == "" ? Colors.red : Colors.blue,
                        iconData2:
                            user.bio == "" ? Icons.error_outline : Icons.edit,
                        onTap: () => Navigator.pushNamed(
                            context, AddBioScreen.routeName)),
                    Divider(color: Colors.grey.shade200),
                    IconWidget(
                        text: 'Work Experience',
                        text2:
                            'List your previous or current work experience to show your experience.',
                        iconData: Icons.work,
                        iconColor: user.workExperience!.isEmpty
                            ? Colors.red
                            : Colors.blue,
                        iconData2: user.workExperience!.isEmpty
                            ? Icons.error_outline
                            : Icons.edit,
                        onTap: () => Navigator.pushNamed(
                            context,
                            user.workExperience!.isEmpty
                                ? WorkExperienceScreen.routeName
                                : WorkExperienceWidget.routeName)),
                    Divider(color: Colors.grey.shade200),
                    IconWidget(
                        text: 'Education',
                        text2:
                            'List your academic degrees to demonstrate to employers that you are qualified for any job within your field of study.',
                        iconData: Icons.menu_book,
                        iconColor:
                            user.education!.isEmpty ? Colors.red : Colors.blue,
                        iconData2: user.education!.isEmpty
                            ? Icons.error_outline
                            : Icons.edit,
                        onTap: () => Navigator.pushNamed(
                            context, EducationScreen.routeName)),
                    Divider(color: Colors.grey.shade200),
                    IconWidget(
                        text: 'Certificates',
                        text2:
                            'List your certificates to help you to get a job',
                        iconData: Icons.library_books,
                        iconData2: user.certificates!.isEmpty
                            ? Icons.error_outline
                            : Icons.edit,
                        iconColor: user.certificates!.isEmpty
                            ? Colors.red
                            : Colors.blue,
                        onTap: () => Navigator.pushNamed(
                            context, CertificateScreen.routeName)),
                    Divider(color: Colors.grey.shade200),
                    IconWidget(
                        text: 'Languages',
                        text2: 'List the languages that you can speak',
                        iconData: Icons.language,
                        iconColor:
                            user.languages!.isEmpty ? Colors.red : Colors.blue,
                        iconData2: user.languages!.isEmpty
                            ? Icons.error_outline
                            : Icons.edit,
                        onTap: () => Navigator.pushNamed(
                            context, LanguageScreen.routeName)),
                    Divider(color: Colors.grey.shade200),
                    IconWidget(
                        text: 'Skills',
                        text2: 'List your skills here',
                        iconColor:
                            user.skills!.isEmpty ? Colors.red : Colors.blue,
                        iconData: Icons.settings_accessibility,
                        iconData2: user.skills!.isEmpty
                            ? Icons.error_outline
                            : Icons.edit,
                        onTap: () => Navigator.pushNamed(
                            context, SkillsScreen.routeName)),
                    Divider(color: Colors.grey.shade200),
                    IconWidget(
                        text: 'Recommended jobs',
                        text2: 'update your recommended jobs here',
                        iconColor:
                            user.skills!.isEmpty ? Colors.red : Colors.blue,
                        iconData: Icons.settings_accessibility,
                        iconData2: user.skills!.isEmpty
                            ? Icons.error_outline
                            : Icons.edit,
                        onTap: () => Navigator.pushNamed(
                            context, RecomendedJobsScreen.routeName)),
                    Divider(color: Colors.grey.shade200),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                    title: const Text('LogOut'),
                                    content:
                                        const Text("Are you sure to log out?"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text("Cancel")),
                                      TextButton(
                                          onPressed: () =>
                                              AuthService().logOut(context),
                                          child: const Text("Yes"))
                                    ]));
                      },
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(
                          Icons.power_settings_new,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                      title: const Text('Logout',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: const Text('Delete'),
                                  content: const Text(
                                      "are you sure you want to delete"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text('No')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text('Yes')),
                                  ],
                                ));
                      },
                      leading: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade200,
                          child: const Icon(Icons.delete)),
                      title: const Text(
                        'Delete account',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
