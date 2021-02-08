import 'package:brew_crew/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on Firebase
  AppUser _userFromFirebase(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser> get user {
    return _auth.authStateChanges().map((User user) => _userFromFirebase(user));
    //return .map(_userFromFirebase);
  }

  // SignInAnounymously
  Future<AppUser> signInAnounmously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      //User user = result.user;
      //   return user;
      return _userFromFirebase(result.user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // User sign out method

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
