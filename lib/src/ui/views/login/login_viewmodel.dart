import 'package:flutter/material.dart';
import 'package:one_signal_example/src/app/app.locator.dart';
import 'package:one_signal_example/src/app/app.router.dart';
import 'package:one_signal_example/src/constant/config.dart';
import 'package:one_signal_example/src/constant/session.dart';
import 'package:one_signal_example/src/helpers/connection_helper.dart';
import 'package:one_signal_example/src/helpers/storage/shared_preferences_manager.dart';
import 'package:one_signal_example/src/injector/injector.dart';
import 'package:one_signal_example/src/services/auth_service.dart';
import 'package:one_signal_example/src/services/user_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FutureViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _userService = locator<UserService>();
  final SharedPreferencesManager _sharedPreferencesManager =
      locatorLocal<SharedPreferencesManager>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool emailValidate = false;
  bool passwordValidate = false;

  @override
  Future futureToRun() => getDeviceInfo();

  Future getDeviceInfo() async {
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    print('Player ID: $osUserID');
    _sharedPreferencesManager.putString(
      Session.playerId,
      osUserID ?? '',
    );
  }

  Future login() async {
    final hasConnection = await ConnectionHelper.hasConnection();

    emailValidate = false;
    passwordValidate = false;
    if (emailController.text.isEmpty) {
      emailValidate = true;
    } else if (passwordController.text.isEmpty) {
      passwordValidate = true;
    } else {
      if (hasConnection) {
        setBusy(true);
        final result = await _authService.login(
          emailController.text,
          passwordController.text,
        );
        if (result != null) {
          var user = await _userService.fetchUser(result.uid);
          _sharedPreferencesManager.putString(Session.uid, result.uid);
          user?.role == Config.customer ? home() : homeAdmin();
        }
        setBusy(false);
        return result;
      } else {
        print('Tidak ada koneksi');
      }
    }
    notifyListeners();
  }

  void home() async => _navigationService.replaceWith(Routes.homeView);

  void homeAdmin() async =>
      _navigationService.navigateTo(Routes.homeAdminView);

  void regis() async => _navigationService.navigateTo(Routes.regisView);
}
