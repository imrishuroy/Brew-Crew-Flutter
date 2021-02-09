import 'package:brew_crew/models/app_user.dart';
import 'package:brew_crew/shared/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on Firebase
  AppUser _userFromFirebase(User user) {
    return user != null
        ? AppUser(
            uid: user.uid,
            // isEmailVerified: user.emailVerified
          )
        : null;
  }

  // _emailVarified(User user) {
  //   return user != null ? AppUser(isEmailVerified: user.emailVerified) : null;
  // }

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

  // Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).updateUserData('0', 'Rishu', 100);

      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //SignIn with email and password

  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Send email verification link
  // sendEmailVerification() async {
  //   User user = _auth.currentUser;
  //   if (!user.emailVerified) {
  //     return await user.sendEmailVerification();
  //   }
  // }

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
