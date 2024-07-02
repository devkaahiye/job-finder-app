import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_findder_app/constants/error_handling.dart';
import 'package:job_findder_app/models/category.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../constants/global_variables.dart';
import '../../../../constants/utils.dart';
import '../../../../provider/userProvider.dart';

class CategoryServices {
  Future<List<Category>> getCategories({
    required BuildContext context,
  }) async {
    List<Category> categries = [];

    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res =
          await http.get(Uri.parse('$uri/api/categories'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer ${userProvider.token}',
      });

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              for (int i = 0; i < jsonDecode(res.body).length; i++) {
                categries.add(
                    Category.fromJson(jsonEncode(jsonDecode(res.body)[i])));
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }

    return categries;
  }

  void save({
    required String name,
    required BuildContext context,
    required VoidCallback onError,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.post(Uri.parse('$uri/api/categories/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ${userProvider.token}',
          },
          body: jsonEncode({"name": name}));

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              Navigator.of(context).pop("refresh");
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

  void update({
    required String id,
    required String name,
    required BuildContext context,
    required VoidCallback onError,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.put(Uri.parse('$uri/api/categories/$id'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ${userProvider.token}',
          },
          body: jsonEncode({"name": name}));

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              Navigator.of(context).pop("refresh");
              showSnackBar(context, 'Successfully updated');
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
    required VoidCallback onSucc,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.delete(
        Uri.parse('$uri/api/categories/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ${userProvider.token}',
        },
      );

      print(res.body);
      print(res.statusCode);

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              onSucc();
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }
  }
}
