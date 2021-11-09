import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:one_signal_example/src/app/app.locator.dart';
import 'package:one_signal_example/src/constant/collection.dart';
import 'package:one_signal_example/src/constant/config.dart';
import 'package:one_signal_example/src/models/chat_message.dart';
import 'package:one_signal_example/src/models/chat_thread.dart';
import 'package:one_signal_example/src/models/user.dart';
import 'package:one_signal_example/src/services/user_service.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class ChatService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final _userService = locator<UserService>();
  var dio = Dio();

  User? user;
  late Query<Map<String, dynamic>> roomQuery;
  String? _queryRoomId;
  ChatThread? thread;

  Future<String> addThread(
    String senderId,
    String senderName,
    String receiverId,
    String receiverName,
  ) async {
    final Map<String, dynamic> thread = ChatThread(
      senderId: senderId,
      senderName: senderName,
      receiverId: receiverId,
      receiverName: receiverName,
    ).toJson();
    var doc = fireStore.collection(Collection.threads).doc();
    doc.set(thread);
    _queryRoomId = doc.id;
    return doc.id;
  }

  Future<List<ChatThread>?> initGetThreads() async {
    List<ChatThread> threads = [];
    user = await _userService.getUser();
    bool isCustomer = user?.role == Config.customer ? true : false;
    roomQuery = fireStore.collection(Collection.threads);
    roomQuery = isCustomer
        ? roomQuery.where('sender_id', isEqualTo: user?.uid)
        : roomQuery.where('receiver_id', isEqualTo: user?.uid);
    roomQuery.get().then((value) {
      value.docs.asMap().forEach((key, data) {
        ChatThread thread = ChatThread.fromJson(data.data());
        threads.add(thread);
      });
    });
    return threads;
  }

  Future<String> initGetThread(String userId, String userName) async {
    String roomId = '';
    user = await _userService.getUser();
    bool isCustomer = user?.role == Config.customer ? true : false;
    String? senderId = isCustomer ? user?.uid : userId;
    String? senderName = isCustomer ? user?.name : userName;
    String? receiverId = isCustomer ? userId : user?.uid;
    String? receiverName = isCustomer ? userName : user?.name;
    roomQuery = fireStore.collection(Collection.threads);
    roomQuery = isCustomer
        ? roomQuery.where('sender_id', isEqualTo: user?.uid)
        : roomQuery.where('receiver_id', isEqualTo: user?.uid);
    roomQuery.get().then((value) async {
      if (value.docs.isEmpty) {
        String data = await addThread(
          senderId ?? '',
          senderName ?? '',
          receiverId ?? '',
          receiverName ?? '',
        );
        roomId = data;
      } else {
        for (var element in value.docs) {
          _queryRoomId = element.id;
          roomId = element.id;
        }
      }
    });
    return roomId;
  }

  Future<String> initGetThreadAdmin(
    String userId,
    String userName,
    String room,
  ) async {
    user = await _userService.getUser();
    bool isCustomer = user?.role == Config.customer ? true : false;
    roomQuery = fireStore.collection(Collection.threads);
    roomQuery = isCustomer
        ? roomQuery.where('sender_id', isEqualTo: user?.uid)
        : roomQuery.where('receiver_id', isEqualTo: user?.uid);
    return room;
  }

  Future<ChatThread?> startSnapshotListenerAdmin(String roomId) async {
    roomQuery = fireStore.collection(Collection.threads);
    user = await _userService.getUser();
    bool isCustomer = user?.role == Config.customer ? true : false;
    roomQuery = isCustomer
        ? roomQuery.where('sender_id', isEqualTo: user?.uid)
        : roomQuery.where('receiver_id', isEqualTo: user?.uid);
    roomQuery.snapshots().listen((event) {
      for (var element in event.docs) {
        if (element.id == roomId) {
          thread = ChatThread.fromJson(element.data());
        }
      }
    });
    readAllChat(thread!);
    return thread;
  }

  Future<ChatThread?> startSnapshotListener(
    String? roomId,
    bool admin,
  ) async {
    roomQuery.snapshots().listen((event) {
      for (var element in event.docs) {
        if (element.id == _queryRoomId) {
          thread = ChatThread.fromJson(element.data());
        }
      }
    });
    readAllChat(thread!);
    return thread;
  }

  void readAllChat(ChatThread data) async {
    user = await _userService.getUser();
    bool customer = user?.role == Config.customer ? true : false;
    bool dataChanged = false;
    data.chats?.forEach((element) {
      if (element.customer != customer && !element.read) {
        element.read = true;
        dataChanged = true;
      }
    });
    if (dataChanged) {
      fireStore
          .collection(Collection.threads)
          .doc(_queryRoomId)
          .update({'chats': data.chats});
    }
  }

  void sendMessage(
    String message,
    String? room,
    String? senderId,
    String? receiverId,
  ) async {
    user = await _userService.getUser();
    bool customer = user?.role == Config.customer ? true : false;
    bool admin = user?.role == Config.admin ? true : false;
    String? roomId = customer ? _queryRoomId : room;
    String? uid = admin ? senderId : receiverId;
    Map<String, dynamic> chat = ChatMessage(
      customer: customer,
      message: message,
      createdAt: DateTime.now(),
    ).toJson();
    fireStore.collection(Collection.threads).doc(roomId).update({
      'chats': FieldValue.arrayUnion([chat])
    });
    fetchPlayerId(
      message,
      roomId ?? '',
      admin,
      uid,
    );
    // sendNotification(message, roomId ?? '', admin, '');
  }

  void fetchPlayerId(
    String message,
    String roomId,
    bool admin,
    String? uid,
  ) async {
    User? userData;
    final DocumentReference document =
        fireStore.collection(Collection.users).doc(uid);
    await document.get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        User data = User.fromJson(snapshot.data() as Map<String, dynamic>);
        userData = data;
      } else {
        print('Document does not exist on the database');
      }
    });
    sendNotification(
      message,
      roomId,
      admin,
      userData?.playerId ?? '',
    );
  }

  void sendNotification(
    String message,
    String roomId,
    bool admin,
    String playerId,
  ) async {
    Response response;
    response = await dio.post(
      'https://onesignal.com/api/v1/notifications',
      data: {
        "app_id": "fc725979-0709-46ec-b685-dd8603fe047a",
        "include_player_ids": [playerId],
        "data": {"room_id": roomId, "admin": admin},
        "contents": {"en": message}
      },
    );
  }
}
