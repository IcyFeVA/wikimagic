import 'package:WikiMagic/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../helpers/helpers.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get user => _firebaseAuth.authStateChanges();


  // MyUser? _userFromFirebaseUser(User user) {
  //   return user != null ? MyUser(uid: user.uid) : null;
  // }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();
      User user = result.user!;

      //return _userFromFirebaseUser(user);
      return user;
    } catch (e) {
      print('ERROR: ${e.toString()}');
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future setupUserData(String userID, String userPageID) async {
    await DatabaseService(uid: userID).updateUserData('-', '-', userPageID);
  }

  // GET UID
  Future<String> getCurrentUID() async {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }
}
