import 'package:flutter/material.dart';
import 'package:one_signal_example/src/app/app.locator.dart';
import 'package:one_signal_example/src/app/app.router.dart';
import 'package:one_signal_example/src/helpers/connection_helper.dart';
import 'package:one_signal_example/src/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool nameValidate = false;
  bool emailValidate = false;
  bool passwordValidate = false;
  String? role;

  Future regis() async {
    final hasConnection = await ConnectionHelper.hasConnection();

    nameValidate = false;
    emailValidate = false;
    passwordValidate = false;
    if (nameController.text.isEmpty) {
      nameValidate = true;
    } else if (emailController.text.isEmpty) {
      emailValidate = true;
    } else if (passwordController.text.isEmpty) {
      passwordValidate = true;
    } else {
      if (hasConnection) {
        setBusy(true);
        final result = await _authService.signUp(
          nameController.text,
          emailController.text,
          passwordController.text,
          role ?? '',
        );
        if (result == 'Signed Up') login();
        setBusy(false);
        return result;
      } else {
        print('Tidak ada koneksi');
      }
    }
    notifyListeners();
  }

  void login() async => _navigationService.replaceWith(Routes.loginView);
}
