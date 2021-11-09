import 'package:flutter/material.dart';
import 'package:one_signal_example/src/app/app.locator.dart';
import 'package:one_signal_example/src/constant/session.dart';
import 'package:one_signal_example/src/helpers/storage/shared_preferences_manager.dart';
import 'package:one_signal_example/src/injector/injector.dart';
import 'package:one_signal_example/src/models/chat_thread.dart';
import 'package:one_signal_example/src/models/message.dart';
import 'package:one_signal_example/src/models/user.dart';
import 'package:one_signal_example/src/services/chat_service.dart';
import 'package:one_signal_example/src/services/message_service.dart';
import 'package:one_signal_example/src/services/user_service.dart';
import 'package:stacked/stacked.dart';

class ChatDetailViewModel extends StreamViewModel<ChatThread?> {
  final _messageService = locator<MessageService>();
  final _chatService = locator<ChatService>();
  final _userService = locator<UserService>();
  final SharedPreferencesManager _sharedPreferencesManager =
      locatorLocal<SharedPreferencesManager>();

  final String? roomId;
  final bool admin;
  late final ChatThread? thread;
  User? user;

  ChatDetailViewModel({
    this.roomId,
    required this.admin,
    this.thread,
  });

  final TextEditingController messageController = TextEditingController();

  @override
  Stream<ChatThread?> get stream => setThread();

  Stream<ChatThread> setThread() async* {
    user = await _userService.getUser();
    setBusy(true);
    var data = admin == true
        ? await _chatService.startSnapshotListenerAdmin(roomId ?? '')
        : await _chatService.startSnapshotListener(
            roomId ?? '',
            admin,
          );
    notifyListeners();
    setBusy(false);
    yield data!;
  }

  Future sendMessage() async {
    _chatService.sendMessage(
      messageController.text,
      roomId,
      data?.senderId,
      data?.receiverId,
    );
    messageController.text = '';
    notifyListeners();
    setThread();
  }

  Stream<List<Message>> fetchMessage() async* {
    String? uid = _sharedPreferencesManager.getString(Session.uid);
    _messageService.getMessageByUserId(uid ?? '');
  }
}
