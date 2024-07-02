import 'package:flutter/material.dart';
import '../models/userModel.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    phone: '',
    sex: '',
    email: '',
    password: '',
    city: '',
    country: '',
    isAdmin: false,
    isAproved: false,
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
