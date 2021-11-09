import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_signal_example/src/constant/collection.dart';
import 'package:one_signal_example/src/constant/session.dart';
import 'package:one_signal_example/src/helpers/storage/shared_preferences_manager.dart';
import 'package:one_signal_example/src/injector/injector.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final SharedPreferencesManager _sharedPreferencesManager =
      locatorLocal<SharedPreferencesManager>();

  // AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<User?> login(String email, String password) async {
    String? playerId = _sharedPreferencesManager.getString(Session.playerId);
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      fireStore
          .collection('users')
          .doc(user.user?.uid)
          .update({'player_id': playerId});

      return user.user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> signUp(
    String name,
    String email,
    String password,
    String role,
  ) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance
            .collection(Collection.users)
            .doc(user?.uid)
            .set({
          'uid': user?.uid,
          'name': name,
          'email': email,
          'password': password,
          'role': role,
          'player_id': '',
        });
      });
      return "Signed Up";
    } catch (e) {
      return e.toString();
    }
  }
}
