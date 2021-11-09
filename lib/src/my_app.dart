
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_signal_example/src/app/app.router.dart';
import 'package:one_signal_example/src/ui/shared/styles.dart';
import 'package:stacked_services/stacked_services.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: mainColor, // this one for android
          statusBarBrightness: Brightness.light // this one for iOS
          ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SI Bang Jaja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      // home: const ChatDetailView(),
    );
  }
}
