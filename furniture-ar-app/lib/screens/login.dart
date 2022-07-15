import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'package:furniture/services/auth.dart';
import 'package:furniture/screens/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  late double height, width;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height * 0.25,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF8E1),
                ),
              ),
              Container(
                height: height * 0.75,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 53, right: 53, top: 100),
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildLoginText(),
                              _buildDash(),
                              _buildEmail(context),
                              _buildPassword(),
                              _buildLoginButton(),
                              _buildSignup(),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: width * 0.2,
            right: width * 0.2,
            top: height * 0.18,
            child: Container(
              height: width * 0.3,
              width: width * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/furniture-logo.jpg"),
                  scale: 6.5,
                ),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginText() {
    return const Text(
      'Log in',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDash() {
    return Container(
      margin: EdgeInsets.only(top: 4, left: 6),
      height: 4,
      width: 40,
      decoration: BoxDecoration(
        color: Color(0xFFDEA057),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(top: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 46.0,
            child: Theme(
              data: themeData.copyWith(
                inputDecorationTheme: themeData.inputDecorationTheme.copyWith(
                  prefixIconColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused)) {
                        return Color(0xFFDEA057);
                      }
                      if (states.contains(MaterialState.error)) {
                        return Colors.red;
                      }
                      return Colors.grey;
                    },
                  ),
                ),
              ),
              child: TextFormField(
                autofocus: false,
                cursorColor: Color(0xFFDEA057),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFDEA057),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFDEA057),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'Enter your email',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA8A8A8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassword() {
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 46.0,
            child: Theme(
              data: themeData.copyWith(
                inputDecorationTheme: themeData.inputDecorationTheme.copyWith(
                  prefixIconColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused)) {
                        return Color(0xFFDEA057);
                      }
                      if (states.contains(MaterialState.error)) {
                        return Colors.red;
                      }
                      return Colors.grey;
                    },
                  ),
                ),
              ),
              child: TextFormField(
                autofocus: false,
                cursorColor: Color(0xFFDEA057),
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFDEA057),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFDEA057),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  prefixIcon: const Icon(
                    Icons.key,
                  ),
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA8A8A8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      height: 96,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          _auth
              .emailLogin(
                  emailController.text.trim(), passwordController.text, context)
              .whenComplete(
            () {
              setState(() {
                _isLoading = false;
              });
              final User? user = FirebaseAuth.instance.currentUser;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => MyHomePage(uid: user!.uid)),
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFFCE9461),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontFamily: "Montserrat",
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _buildSignup() {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SignUp(),
          ),
          (route) => false,
        ),
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an account? ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
