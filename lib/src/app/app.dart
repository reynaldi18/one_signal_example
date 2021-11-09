import 'package:one_signal_example/src/services/auth_service.dart';
import 'package:one_signal_example/src/services/chat_service.dart';
import 'package:one_signal_example/src/services/message_service.dart';
import 'package:one_signal_example/src/services/user_service.dart';
import 'package:one_signal_example/src/ui/views/chat/chat_detail_view.dart';
import 'package:one_signal_example/src/ui/views/home/home_view.dart';
import 'package:one_signal_example/src/ui/views/home_admin/home_admin_view.dart';
import 'package:one_signal_example/src/ui/views/login/login_view.dart';
import 'package:one_signal_example/src/ui/views/regis/regis_view.dart';
import 'package:one_signal_example/src/ui/views/splash_screen/splash_screen_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: SplashScreenView, initial: true),
    CupertinoRoute(page: LoginView),
    CupertinoRoute(page: RegisView),
    CupertinoRoute(page: HomeView),
    CupertinoRoute(page: HomeAdminView),
    CupertinoRoute(page: ChatDetailView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: MessageService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: ChatService),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
  /** flutter pub run build_runner build --delete-conflicting-outputs */
}
