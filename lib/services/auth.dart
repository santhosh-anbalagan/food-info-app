import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anonymously
  Future signInAnon() async {
    try {
      //AuthResult class name has changed to UserCredential
      UserCredential result = await _auth.signInAnonymously();
      //FirebaseUser class name has changed to User
      User? user = result.user;
      return user;
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }

  // sign in with email & password

  // register  with email & password

  //signout

}
