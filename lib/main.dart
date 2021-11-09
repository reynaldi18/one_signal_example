import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_signal_example/src/app/app.locator.dart';
import 'package:one_signal_example/src/injector/injector.dart';
import 'package:one_signal_example/src/my_app.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await setupInjector();
    setupLocator();
    runApp(const MyApp());
  } catch (error, stacktrace) {
    print('$error & $stacktrace');
  }
}
