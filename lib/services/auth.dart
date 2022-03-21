import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get onAuthStateChanged => _firebaseAuth.authStateChanges();

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e.toString());
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

  // GET UID
  Future<String> getCurrentUID() async {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<User?> getUser() async {
    User? firebaseUser = _firebaseAuth.currentUser;
    firebaseUser ??= await _firebaseAuth.authStateChanges().first;
    return firebaseUser;
  }
}
