import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../screens/home.dart';
import '../screens/login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    //return either home or authenticate widget
    if (user == null) {
      return const Login();
    } else {
      return MyHomePage(uid: user.uid);
    }
  }
}
