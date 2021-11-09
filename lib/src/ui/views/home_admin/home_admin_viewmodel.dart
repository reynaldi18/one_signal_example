import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_signal_example/src/app/app.locator.dart';
import 'package:one_signal_example/src/app/app.router.dart';
import 'package:one_signal_example/src/constant/collection.dart';
import 'package:one_signal_example/src/constant/config.dart';
import 'package:one_signal_example/src/models/chat_thread.dart';
import 'package:one_signal_example/src/models/user.dart';
import 'package:one_signal_example/src/services/chat_service.dart';
import 'package:one_signal_example/src/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeAdminViewModel extends FutureViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _chatService = locator<ChatService>();
  late Query<Map<String, dynamic>> roomQuery;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  User? userData;
  List<ChatThread> threads = [];
  List<String> threadId = [];

  @override
  Future futureToRun() => initGetThreads();

  Future initGetThreads() async {
    threads.clear();
    User user = await _userService.getUser();
    bool isCustomer = user.role == Config.customer ? true : false;
    roomQuery = fireStore.collection(Collection.threads);
    roomQuery = isCustomer
        ? roomQuery.where('sender_id', isEqualTo: user.uid)
        : roomQuery.where('receiver_id', isEqualTo: user.uid);
    roomQuery.get().then((value) {
      value.docs.asMap().forEach((key, data) {
        ChatThread thread = ChatThread.fromJson(data.data());
        threads.add(thread);
        threadId.add(data.id);
        notifyListeners();
      });
    });
  }

  Future setUserThread(String roomId) async {
    User user = await _userService.getUser();
    await _chatService.initGetThreadAdmin(
      user.uid ?? '',
      user.name ?? '',
      roomId,
    );
    showDetailChat(roomId);
  }

  void showDetailChat(String roomId) => _navigationService.navigateTo(
        Routes.chatDetailView,
        arguments: ChatDetailViewArguments(
          roomId: roomId,
          admin: true,
        ),
      );
}
