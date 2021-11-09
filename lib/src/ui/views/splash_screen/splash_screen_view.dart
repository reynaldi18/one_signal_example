import 'package:flutter/material.dart';
import 'package:one_signal_example/src/constant/config.dart';
import 'package:one_signal_example/src/helpers/scalable_dp.dart';
import 'package:one_signal_example/src/ui/shared/images.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:stacked/stacked.dart';

import 'splash_screen_viewmodel.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId(Config.oneSignalAppID);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 82,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  logo,
                  width: SDP.sdp(100),
                  height: SDP.sdp(100),
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SplashScreenViewModel(),
    );
  }
}
