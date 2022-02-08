// login screen

import 'package:flutter/material.dart';
import 'package:qr_scanner/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.black,
            iconSize: 35.0,
            icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
              child: Image.asset(
                'assets/logo.png',
                height: 170,
                width: 170,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: const Text(
                'Welcome Back!',
                style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                    color: Color(0xFF1E1E1E)),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 20.0),
              child: const Text(
                //Need to change this line
                'Log in to your existent account of QR Scanner',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  height: 1.4,
                  color: Color(0xFFA0A0A0),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: RaisedButton(
                child: const Text('Guest Login'),
                onPressed: () async {
                  dynamic result = await _auth.signInAnon();
                  if (result == null) {
                    print('Error signing in');
                  } else {
                    print('Signed In');
                    print(result.uid);
                  }
                },
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: RaisedButton(
                child: const Text('User Login'),
                onPressed: () => Navigator.pushNamed(context, '/userlogin'),
//                  async {
//                    dynamic result = await _auth.signInAnon();
//                    if (result == null) {
//                      print('Error signing in');
//                    } else {
//                      print('Signed In');
//                      print(result.uid);
//                    }
//                  }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
