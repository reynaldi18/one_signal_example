import 'package:one_signal_example/src/constant/session.dart';
import 'package:one_signal_example/src/helpers/storage/shared_preferences_manager.dart';
import 'package:one_signal_example/src/injector/injector.dart';

class HttpHelper {
  final SharedPreferencesManager _sharedPreferencesManager =
      locatorLocal<SharedPreferencesManager>();

  getToken() => _sharedPreferencesManager.getString(Session.token);

}
