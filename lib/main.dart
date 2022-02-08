import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/screens/wrapper.dart';
import 'screens/home/home.dart';
import 'screens/home/history.dart';
import 'screens/authenticate/login.dart';
import 'screens/authenticate/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
      routes: {
        '/home': (context) => HomePage(),
        '/history': (context) => HistoryPage(),
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
      },
    ),
  );
}
