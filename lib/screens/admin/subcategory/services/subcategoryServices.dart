import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_findder_app/models/subCategories.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../constants/error_handling.dart';
import '../../../../constants/appColors.dart';
import '../../../../constants/utils.dart';
import '../../../../provider/userProvider.dart';

class SubCategoryServices {
  Future<List<SubCategory>> getSubCategories({
    required BuildContext context,
  }) async {
    List<SubCategory> subcategries = [];

    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res =
          await http.get(Uri.parse('$uri/api/subcategories/'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer ${userProvider.token}',
      });

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              for (int i = 0; i < jsonDecode(res.body).length; i++) {
                subcategries.add(
                    SubCategory.fromJson(jsonEncode(jsonDecode(res.body)[i])));
              }
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }

    return subcategries;
  }

  void save({
    required String name,
    required String category,
    required VoidCallback onError,
    required BuildContext context,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.post(Uri.parse('$uri/api/subcategories/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ${userProvider.token}',
          },
          body: jsonEncode({"name": name, "category": category}));

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
    required String category,
    required VoidCallback onError,
    required BuildContext context,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res =
          await http.put(Uri.parse('$uri/api/subcategories/$id'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'authorization': 'Bearer ${userProvider.token}',
              },
              body: jsonEncode({"name": name, "category": category}));

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              Navigator.of(context).pop("refresh");
              showSnackBar(context, 'Successfully updated');
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

  void delete({
    required String id,
    required BuildContext context,
    required VoidCallback onSucc,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.delete(
        Uri.parse('$uri/api/subcategories/$id'),
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
