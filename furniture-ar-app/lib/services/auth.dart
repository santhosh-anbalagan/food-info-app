import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture/models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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

// a simple sialog to be visible everytime some error occurs
  showErrDialog(BuildContext context, String err) {
    // to hide the keyboard, if it is still p
    FocusScope.of(context).requestFocus(new FocusNode());
    return showDialog(
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(err),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"),
          ),
        ],
      ),
      context: context,
    );
  }

  // sign Up  with email & password
  Future emailSignUp(
      String email, String password, BuildContext context) async {
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
          showErrDialog(context, ex.toString());
          return null;
        case 'invalid-email':
          showErrDialog(context, ex.toString());
          return null;
        case 'weak-password':
          showErrDialog(context, ex.toString());
          return null;
        case 'operation-not-allowed':
          showErrDialog(context, ex.toString());
          return null;
        default:
          showErrDialog(context, ex.toString());
          return null;
      }
    }
  }

  // login with email & password
  Future emailLogin(String email, String password, BuildContext context) async {
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
          showErrDialog(context, ex.toString());
          return null;
        case 'invalid-email':
          showErrDialog(context, ex.toString());
          return null;
        case 'user-not-found':
          showErrDialog(context, ex.toString());
          return null;
        case 'wrong-password':
          showErrDialog(context, ex.toString());
          return null;
        default:
          showErrDialog(context, ex.toString());
          return null;
      }
    }
  }

  //signout
  Future signOut(BuildContext context) async {
    try {
      return await _auth.signOut();
    } catch (ex) {
      showErrDialog(context, ex.toString());
      return null;
    }
  }
}
