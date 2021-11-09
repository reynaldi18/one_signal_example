import 'dart:async';

import 'package:one_signal_example/src/app/app.locator.dart';
import 'package:one_signal_example/src/app/app.router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashScreenViewModel extends FutureViewModel {
  final _navigationService = locator<NavigationService>();

  final _duration = const Duration(seconds: 2);

  @override
  Future futureToRun() => versionCheck();

  Future versionCheck() async {
    // String? token = HttpHelper().getToken();

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      var roomId = result.notification.additionalData!['room_id'];
      var admin = result.notification.additionalData!['admin'];
      if (roomId != null) {
        showChatRoom(roomId, admin);
      } else {
        Timer(_duration, navigateToLogin);
      }
    });

    Timer(_duration, navigateToLogin);
  }

  void navigateToLogin() => _navigationService.replaceWith(Routes.loginView);

  void showChatRoom(
    String roomId,
    bool admin,
  ) =>
      _navigationService.replaceWith(
        Routes.chatDetailView,
        arguments: ChatDetailViewArguments(
          roomId: roomId,
          admin: admin,
        ),
      );

// void navigateToDashboard() => _navigationService.replaceWith(Routes.mainView);
}
