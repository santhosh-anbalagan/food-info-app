import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qr_scanner/models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();

class AuthService {
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

  // sign Up  with email & password
  Future emailSignUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (ex) {
      switch (ex) {
        case 'email-already-in-use':
          print(ex.toString());
          return null;
        case 'invalid-email':
          print(ex.toString());
          return null;
        case 'weak-password':
          print(ex.toString());
          return null;
        case 'operation-not-allowed':
          print(ex.toString());
          return null;
        default:
          print(ex.toString());
          return null;
      }
    }
  }

  // login with email & password
  Future emailLogin(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (ex) {
      switch (ex) {
        case 'user-disabled':
          print(ex.toString());
          return null;
        case 'invalid-email':
          print(ex.toString());
          return null;
        case 'user-not-found':
          print(ex.toString());
          return null;
        case 'wrong-password':
          print(ex.toString());
          return null;
        default:
          print(ex.toString());
          return null;
      }
    }
  }

  // Google Sign in
  Future googleLogin() async {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential result = await _auth.signInWithCredential(credential);
    User? user = result.user;
    return _userFromFirebaseUser(user);
  }

  //signout
  Future signOut() async {
    try {
      User? user = await _auth.currentUser;
      if (user?.providerData[1].providerId == 'google.com') {
        return await googleSignIn.disconnect();
      }
      return await _auth.signOut();
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }
}
