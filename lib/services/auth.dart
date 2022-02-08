import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_scanner/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on Firebase user
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        //.map((User? user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      //AuthResult class name has changed to UserCredential
      UserCredential result = await _auth.signInAnonymously();
      //FirebaseUser class name has changed to User
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }

  // sign in with email & password

  // register  with email & password

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }
}
