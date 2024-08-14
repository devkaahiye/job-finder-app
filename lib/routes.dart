import 'package:flutter/material.dart';
import 'package:job_findder_app/models/category.dart';
import 'package:job_findder_app/models/jobs.dart' ;
import 'package:job_findder_app/models/subCategories.dart';
import 'package:job_findder_app/models/userModel.dart' hide Category;
import 'package:job_findder_app/screens/admin/applied_jobs/screens/admin_applied_jobs.dart';
import 'package:job_findder_app/screens/client/account/screens/update_profile_screen.dart';
import 'package:job_findder_app/screens/client/recomended_screen.dart';
import '/screens/admin/admin.dart';
import '/screens/admin/category/screens/add_category.dart';
import '/screens/admin/category/screens/categories.dart';
import '/screens/admin/category/screens/update_category.dart';
import '/screens/admin/jobs/screens/add_jobs.dart';
import '/screens/admin/jobs/screens/jobs_screen.dart';
import '/screens/admin/jobs/screens/update_jobs.dart';
import '/screens/admin/subcategory/screens/add_subcategory.dart';
import '/screens/admin/subcategory/screens/subcategories.dart';
import '/screens/admin/subcategory/screens/update_subcategory.dart';
import '/screens/admin/users/screens/usersList.dart';
import '/screens/auth/screens/login.dart';
import '/screens/auth/screens/register.dart';
import '/screens/client/account/screens/bio.dart';
import '/screens/client/account/screens/certificates.dart';
import '/screens/client/account/screens/education.dart';
import '/screens/client/account/screens/languages.dart';
import '/screens/client/account/screens/skills.dart';
import '/screens/client/account/screens/workExperience.dart';
import '/screens/client/account/widgets/workExperienceWidget.dart';
import '/screens/client/home.dart';
import '/screens/splash_screen.dart';
import 'screens/admin/users/screens/adminUsersList.dart';
import 'screens/auth/screens/otp_screen.dart';
import 'screens/client/account/screens/add_bio.dart';
import 'screens/client/account/screens/add_certificates.dart';
import 'screens/client/account/screens/add_education.dart';
import 'screens/client/account/screens/add_language.dart';
import 'screens/client/account/screens/add_skills.dart';
import 'screens/client/account/screens/add_workExperience.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Home.routeName:
      return MaterialPageRoute(builder: (_) => const Home());
    case RecomendedJobsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const RecomendedJobsScreen());
    case AdminScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AdminScreen());
    case UserListScreen.routeName:
      return MaterialPageRoute(builder: (_) => const UserListScreen());
    case AdminUsersScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AdminUsersScreen());
    case JobsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const JobsScreen());
    case AddJobsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddJobsScreen());
    case UpdateJobsScreen.routeName:
      final job = routeSettings.arguments as Job;
      return MaterialPageRoute(builder: (_) => UpdateJobsScreen(job: job));
    case AdminAppliedJobs.routeName:
      return MaterialPageRoute(builder: (_) => const AdminAppliedJobs());
    case CategoriesScreen.routeName:
      return MaterialPageRoute(builder: (_) => const CategoriesScreen());
    case AddCategoryScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddCategoryScreen());
    case UpdateCategoryScreen.routeName:
      final category = routeSettings.arguments as Category;
      return MaterialPageRoute(
          builder: (_) => UpdateCategoryScreen(category: category));
    case SubcategoriesScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SubcategoriesScreen());
    case AddSubCategoryScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddSubCategoryScreen());
    case UpdateSubCategoryScreen.routeName:
      final subcategory = routeSettings.arguments as SubCategory;
      return MaterialPageRoute(
          builder: (_) => UpdateSubCategoryScreen(subCategory: subcategory));
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case UpdateProfileScreen.routeName:
      final user = routeSettings.arguments as User;
      return MaterialPageRoute(builder: (_) => UpdateProfileScreen(user: user));
    case BioScreen.routeName:
      return MaterialPageRoute(builder: (_) => const BioScreen());
    case CertificateScreen.routeName:
      return MaterialPageRoute(builder: (_) => const CertificateScreen());
    case EducationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const EducationScreen());
    case LanguageScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LanguageScreen());
    case SkillsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SkillsScreen());
    case WorkExperienceScreen.routeName:
      return MaterialPageRoute(builder: (_) => const WorkExperienceScreen());
    case WorkExperienceWidget.routeName:
      return MaterialPageRoute(builder: (_) => const WorkExperienceWidget());
    case AddBioScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddBioScreen());
    case AddCertificateScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddCertificateScreen());
    case AddEducationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddEducationScreen());
    case AddEducationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddEducationScreen());
    case AddSkillsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddSkillsScreen());
    case AddWorkExperienceScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddWorkExperienceScreen());
    // case WorkExperienceWidget.routeName:
    //   return MaterialPageRoute(builder: (_) => const WorkExperienceWidget());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case RegisterScreen.routeName:
      return MaterialPageRoute(builder: (_) => const RegisterScreen());
    case OtpScreen.routeName:
      return MaterialPageRoute(builder: (_) => OtpScreen());
    default:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
  }
}
