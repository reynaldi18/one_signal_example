import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_signal_example/src/constant/session.dart';
import 'package:one_signal_example/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class UserService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<User?> fetchUser(String uid) async {
    User? userData;
    final DocumentReference document = fireStore.collection('users').doc(uid);
    await document.get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        print('Document data: ${snapshot.data()}');
        User user = User.fromJson(snapshot.data() as Map<String, dynamic>);
        saveUserInfo(user);
        userData = user;
      } else {
        print('Document does not exist on the database');
      }
    });
    return userData;
  }

  Future<void> saveUserInfo(User? data) async {
    final User? user = data;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Session.user, jsonEncode(user));
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> userMap;
    final String userStr = prefs.getString(Session.user)!;
    userMap = jsonDecode(userStr) as Map<String, dynamic>;

    final User user = User.fromJson(userMap);
    return user;
  }
}
