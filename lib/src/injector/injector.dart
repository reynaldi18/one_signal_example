import 'package:get_it/get_it.dart';
import 'package:one_signal_example/src/helpers/storage/shared_preferences_manager.dart';

GetIt locatorLocal = GetIt.instance;

Future setupInjector() async {
  SharedPreferencesManager? sharedPreferencesManager =
      await SharedPreferencesManager.getInstance();
  locatorLocal
      .registerSingleton<SharedPreferencesManager>(sharedPreferencesManager!);
}
