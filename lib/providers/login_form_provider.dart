import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool _invalidCredentials = false;

  bool get isLoading => _isLoading;
  bool get invalidCredentials => _invalidCredentials;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set invalidCredentials(bool value) {
    _invalidCredentials = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
