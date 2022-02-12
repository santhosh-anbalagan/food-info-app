//signup screen
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner/screens/home/home.dart';
import 'package:qr_scanner/services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  late String email;
  late String password;

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontFamily: 'Product Sans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Product Sans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Color(0XFFFF7D54),
              ),
              hintText: 'Enter new Username',
              hintStyle: TextStyle(
                fontFamily: 'Product Sans',
                color: Color(0xFFA0A0A0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontFamily: 'Product Sans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Product Sans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Color(0XFFFF7D54),
              ),
              hintText: 'Enter your Email',
              hintStyle: TextStyle(
                fontFamily: 'Product Sans',
                color: Color(0xFFA0A0A0),
              ),
            ),
            validator: (_val) {
              if (_val!.isEmpty) {
                return "Can't be empty";
              } else {
                return null;
              }
            },
            onChanged: (val) {
              email = val;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'New Password',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontFamily: 'Product Sans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextFormField(
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Product Sans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0XFFFF7D54),
              ),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(
                fontFamily: 'Product Sans',
                color: Color(0xFFA0A0A0),
              ),
            ),
            validator: (_val) {
              if (_val!.isEmpty) {
                return "Can't be empty";
              } else {
                return null;
              }
            },
            onChanged: (val) {
              password = val;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 3.0,
        onPressed: () => _auth.emailSignUp(email.trim(), password).whenComplete(
          () {
            final User? user = FirebaseAuth.instance.currentUser;

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage(uid: user!.uid)),
            );
          },
        ),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: const Color(0XFFFF7D54),
        child: const Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Product Sans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign up with',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontFamily: 'Product Sans',
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Twitter'),
            AssetImage(
              'assets/twitter.png',
            ),
          ),
          _buildSocialBtn(
            () => print('SignUp with Facebook'),
            AssetImage(
              'assets/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('SignUp with Google'),
            AssetImage(
              'assets/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          print('Sign In Button Pressed');
          Navigator.of(context).pushNamed('/login');
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Already have an Account? ',
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  color: Colors.grey,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(40.0, 70.0, 40.0, 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Product Sans',
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            _buildEmailTF(),
                            SizedBox(height: 30.0),
                            _buildUsernameTF(),
                            SizedBox(height: 30.0),
                            _buildNewPasswordTF(),
                            SizedBox(height: 30.0),
                            _buildSignUpBtn(),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      _buildSignUpWithText(),
                      _buildSocialBtnRow(),
                      _buildSignupBtn(),
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
