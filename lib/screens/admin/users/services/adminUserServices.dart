import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../constants/error_handling.dart';
import '../../../../constants/appColors.dart';
import '../../../../constants/utils.dart';
import '../../../../provider/userProvider.dart';
import '/models/userModel.dart';

class AdminUserServices {
  Future<List<User>> getAllUsers({
    required BuildContext context,
  }) async {
    List<User> usersList = [];
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.get(
        Uri.parse('$uri/api/users'),
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
                usersList
                    .add(User.fromJson(jsonEncode(jsonDecode(res.body)[i])));
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }

    return usersList;
  }

  Future<List<User>> getAdminUsers({
    required BuildContext context,
  }) async {
    List<User> usersList = [];
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.get(
        Uri.parse('$uri/api/users/admin/users'),
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
              for (var i = 0; i < jsonDecode(res.body).length; i++) {
                usersList
                    .add(User.fromJson(jsonEncode(jsonDecode(res.body)[i])));
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }

    return usersList;
  }
}
