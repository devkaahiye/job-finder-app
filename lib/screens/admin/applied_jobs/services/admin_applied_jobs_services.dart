import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_findder_app/models/userModel.dart' hide AppliedJob;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/appColors.dart';
import '../../../../constants/error_handling.dart';
import '../../../../constants/utils.dart';
import '../../../../models/appliedJobsModel.dart';
import '../../../../provider/userProvider.dart';
import '../screens/admin_applied_jobs.dart';

class AdminAppliedJobsServices {
  Future<List<AppliedJob>> getAppliedJobs({
    required BuildContext context,
  }) async {
    List<AppliedJob> appliedJobs = [];

    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res =
          await http.get(Uri.parse('$uri/api/appliedJobs'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      print(res.body);

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              final List<dynamic> data = jsonDecode(res.body);
              appliedJobs =
                  data.map((item) => AppliedJob.fromMap(item)).toList();
            });
      }
    } catch (e) {
      if (context.mounted) {
        print(e.toString());
        showSnackBar(context, 'Error: $e');
      }
    }

    return appliedJobs;
  }

  Future<void> updateAppliedJob(BuildContext context, String jobId,
      String status, VoidCallback onSuccess) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('userToken');
      final response = await http.post(
        Uri.parse('$uri/api/appliedJobs/$jobId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'applicationStatus': status}),
      );

      print(response.body);

      if (response.statusCode == 200) {
        if (context.mounted) {
          showSnackBar(context, "Update Successfully");
          onSuccess();
        }
      } else {
        if (context.mounted) {
          showSnackBar(context, "Failed to update");
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
