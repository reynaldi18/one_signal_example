import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_signal_example/src/models/message.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class MessageService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<List<Message>> getMessageByUserId(String userId) async* {
    try {
      fireStore
          .collection('messages')
          .where('user_id', isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot list) {
        var result = list.docs.map<Message>((DocumentSnapshot message) {
          return Message.fromJson(message.data() as Map<String, dynamic>);
        }).toList();

        result.sort(
          (Message a, Message b) =>
              a.createdAt!.compareTo(b.createdAt ?? DateTime.now()),
        );
        return result;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addMessage({
    required String uid,
    required bool isFromUser,
    required String message,
  }) async {
    try {
      fireStore.collection('messages').add({
        'user_id': uid,
        'is_from_user': isFromUser,
        'message': message,
        'created_at': DateTime.now().toString(),
        'updated_at': DateTime.now().toString(),
      }).then(
        (value) => print('Pesan Berhasil Dikirim!'),
      );
    } catch (e) {
      throw Exception('Pesan Gagal Dikirim!');
    }
  }
}
