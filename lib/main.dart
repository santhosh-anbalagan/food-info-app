import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/screens/authenticate/signup.dart';
import 'package:qr_scanner/screens/wrapper.dart';
import 'package:qr_scanner/services/auth.dart';
import 'models/user.dart';
import 'screens/home/home.dart';
import 'screens/home/history.dart';
import 'screens/authenticate/login.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
        routes: {
          '/home': (context) => HomePage(),
          '/history': (context) => HistoryPage(),
          '/signup': (context) => SignUp(),
          '/login': (context) => LoginPage(),
        },
      ),
    ),
  );
}
