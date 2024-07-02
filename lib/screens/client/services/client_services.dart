import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:job_findder_app/models/category.dart';
import 'package:job_findder_app/screens/client/home.dart';
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/jobs.dart';
import '../../../models/userModel.dart';
import '../../../provider/userProvider.dart';

class ClientServices {
  Future<List<Job>> getRecommendedJobs({
    required BuildContext context,
  }) async {
    List<Job> jobsList = [];
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.get(
        Uri.parse('$uri/api/jobs/recommended/jobs/${user.id.toString()}'),
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

  void add({
    required List<String> categories,
    required BuildContext context,
    required VoidCallback onError,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.put(
          Uri.parse(
              '$uri/api/users/add-recommended/${userProvider.id.toString()}'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ${userProvider.token}',
          },
          body: jsonEncode({"categories": categories}));

      print(res.statusCode);
      print(res.body);

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
              showSnackBar(context, 'Successfully Added');
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

  void bookmarkJob(
      {required BuildContext context,
      required VoidCallback onError,
      required String id}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse('$uri/api/users/add-to-bookmark/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${userProvider.user.token}',
        },
      );

      // print(res.statusCode);
      // print(res.body);

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              User user = userProvider.user
                  .copyWith(bookMarks: jsonDecode(res.body)['bookMarks']);
              userProvider.setUserFromModel(user);
              showSnackBar(context, 'Successfully Added');
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

  void removeItem({required BuildContext context, required int index}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.post(Uri.parse('$uri/api/users/add/bookmark'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'authorization': 'Bearer ${userProvider.user.token}',
              },
              body: jsonEncode({'index': index}));

      print(res.statusCode);
      print(res.body);

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              User user = userProvider.user
                  .copyWith(bookMarks: jsonDecode(res.body)['bookMarks']);
              userProvider.setUserFromModel(user);
              showSnackBar(context, 'Successfully removed');
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }
  }
}
