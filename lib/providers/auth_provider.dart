import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _loggedIn = false;
  String? _token;

  bool get isLoggedIn => _loggedIn;
  String? get token => _token;

  void login() {
    _loggedIn = true;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }
}
