import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:job_findder_app/constants/appColors.dart';
import 'package:job_findder_app/constants/utils.dart';
import 'package:provider/provider.dart';

import '../../../../provider/userProvider.dart';

class JobDetailsServices {
  Future<void> createAppliedJob(
      {required BuildContext context,
      required String userId,
      required String jobId,
      required VoidCallback onError}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;

      final response = await http.post(
        Uri.parse('$uri/api/appliedJobs'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${user.token}',
        },
        body: jsonEncode({
          'userId': userId,
          'jobId': jobId,
          'applicationStatus': 'Applied',
        }),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        if (context.mounted) {
          var user = Provider.of<UserProvider>(context, listen: false);
          user.setUser(response.body);
          showSnackBar(context, "Applied successfully");
          onError();
        }
      } else {
        showSnackBar(context, jsonDecode(response.body)['message']);
        onError();
      }
    } catch (e) {
      if (context.mounted) {
        onError();
        showSnackBar(context, 'Error: $e');
      }
    }
  }
}
