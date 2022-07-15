import 'package:flutter/material.dart';
import 'package:furniture/screens/login.dart';
import 'package:furniture/screens/sofa.dart';

import 'package:flutter/material.dart';
import 'package:furniture/services/auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<MyHomePage> createState() => _MyHomePageState(uid);
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _auth = AuthService();
  final String uid;

  _MyHomePageState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Place Furniture in your Room",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF57C00),
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFE0D8B0),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(height: 200),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFDEA057),
                  fixedSize: Size(150, 50),
                  shape: StadiumBorder(),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Sofa(),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: const [
                      ImageIcon(
                        AssetImage("assets/household-sofa.png"),
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          'Sofa',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE0D8B0),
                  fixedSize: Size(150, 50),
                  shape: StadiumBorder(),
                ),
                onPressed: () async {
                  await _auth.signOut(context).whenComplete(
                        () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                          (route) => false,
                        ),
                      );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app_rounded,
                        size: 24,
                      ),
                      SizedBox(width: 11),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
