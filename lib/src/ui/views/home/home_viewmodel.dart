import 'package:one_signal_example/src/app/app.locator.dart';
import 'package:one_signal_example/src/app/app.router.dart';
import 'package:one_signal_example/src/models/user.dart';
import 'package:one_signal_example/src/services/chat_service.dart';
import 'package:one_signal_example/src/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FutureViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _chatService = locator<ChatService>();

  User? userData;

  @override
  Future futureToRun() => getUserData();

  Future<User?> getUserData() async {
    var user = await _userService.getUser();
    userData = user;
    notifyListeners();
    return user;
  }

  Future setUserThread(String userId, String userName) async {
    await _chatService.initGetThread(userId, userName);
    showChatDetail();
  }

  void showChatDetail() => _navigationService.navigateTo(Routes.chatDetailView);
}
