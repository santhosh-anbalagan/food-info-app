import 'package:flutter/material.dart';
import 'screens/home/home.dart';
import 'screens/home/history.dart';
import 'screens/authenticate/login.dart';
import 'screens/authenticate/signup.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          '/home': (context) => HomePage(),
          '/history': (context) => HistoryPage(),
          '/signup': (context) => SignUpPage(),
          '/login': (context) => LoginPage(),
        },
      ),
    );
