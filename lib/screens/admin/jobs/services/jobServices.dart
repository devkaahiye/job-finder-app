import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:job_findder_app/constants/error_handling.dart';
import 'package:job_findder_app/models/jobs.dart';
import 'package:provider/provider.dart';

import '../../../../constants/appColors.dart';
import '../../../../constants/utils.dart';
import '../../../../provider/userProvider.dart';

class JobServices {
  Future<List<Job>> getAllJobs({
    required BuildContext context,
  }) async {
    List<Job> jobsList = [];
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.get(
        Uri.parse('$uri/api/jobs/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );

      // print(res.statusCode);
      // print(res.body);
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              for (var i = 0; i < jsonDecode(res.body).length; i++) {
                jobsList.add(Job.fromJson(jsonEncode(jsonDecode(res.body)[i])));
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
       
        showSnackBar(context, 'Error: $e');
      }
    }

    return jobsList;
  }

  Future<List<Job>> getRecentJobs({
    required BuildContext context,
  }) async {
    List<Job> jobsList = [];
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.get(
        Uri.parse('$uri/api/jobs/recent/jobs'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );

      // print(res.statusCode);
      // print(res.body);
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              for (var i = 0; i < jsonDecode(res.body).length; i++) {
                jobsList.add(Job.fromJson(jsonEncode(jsonDecode(res.body)[i])));
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }

    return jobsList;
  }

  void save({
    required Job job,
    required String category,
    required String subcategory,
    required BuildContext context,
    required VoidCallback onError,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.post(Uri.parse('$uri/api/jobs/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ${user.token}',
          },
          body: jsonEncode({
            "title": job.title,
            "category": category,
            "subcategory": subcategory,
            "company": job.company,
            "country": job.country,
            "state": job.state,
            "city": job.city,
            "description": job.description,
            "responsibilities": job.responsibilities,
            "qualifications": job.qualifications,
            "salary": job.salary,
            "companyLogoUrl": job.companyLogoUrl,
            "experienceRequirements": job.experienceRequirements,
            "jobOverview": job.jobOverview,
            "jobType": job.jobType,
          }));

      print(res.statusCode);
      print(res.body);
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              showSnackBar(context, 'Job saved successfully');
              Navigator.of(context).pop("refresh");
            });
      }
      if (res.statusCode != 201) {
        onError();
      }
    } catch (e) {
      if (context.mounted) {
        onError();
        showSnackBar(context, 'Error: $e');
      }
    }
  }

  void update({
    required Job job,
    required String id,
    required String category,
    required String subcategory,
    required BuildContext context,
    required VoidCallback onError,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.put(Uri.parse('$uri/api/jobs/$id'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ${user.token}',
          },
          body: jsonEncode({
            "title": job.title,
            "category": category,
            "subcategory": subcategory,
            "company": job.company,
            "country": job.country,
            "state": job.state,
            "city": job.city,
            "description": job.description,
            "responsibilities": job.responsibilities,
            "qualifications": job.qualifications,
            "salary": job.salary,
            "companyLogoUrl": job.companyLogoUrl,
            "experienceRequirements": job.experienceRequirements,
            "jobOverview": job.jobOverview,
            "jobType": job.jobType,
          }));

      print(res.statusCode);
      print(res.body);
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              showSnackBar(context, 'Job updated successfully');
              Navigator.of(context).pop("refresh");
            });
      }
      if (res.statusCode != 200) {
        onError();
      }
    } catch (e) {
      if (context.mounted) {
        onError();
        showSnackBar(context, 'Error: $e');
      }
    }
  }

  void delete({
    required String id,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.delete(
        Uri.parse('$uri/api/jobs/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
      );

      print(res.statusCode);
      print(res.body);
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              showSnackBar(context, 'Job deleted successfully');
              onSuccess();
              Navigator.of(context).pop("refresh");
            });
      }
      if (res.statusCode != 200) {}
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }
  }
}
