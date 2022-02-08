import 'package:flutter/material.dart';
import 'package:qr_scanner/screens/home/home.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Authenticate();
    //return either home or authenticate widget
  }
}
