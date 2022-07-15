import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'package:furniture/services/auth.dart';
import 'package:furniture/screens/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseDatabase database = FirebaseDatabase.instance;

  final AuthService _auth = AuthService();
  late double height, width;
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
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
                    padding: EdgeInsets.only(left: 53, right: 53, top: 90),
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildSignUpText(),
                              _buildDash(),
                              _buildFirstName(),
                              _buildLastName(),
                              _buildEmail(),
                              _buildPassword(),
                              _buildConfirmPassword(),
                              _buildSignUpButton(),
                              _buildLogin(),
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

  Widget _buildSignUpText() {
    return const Text(
      'Sign up',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDash() {
    return Container(
      margin: EdgeInsets.only(top: 4, left: 10),
      height: 4,
      width: 40,
      decoration: BoxDecoration(
        color: Color(0xFFDEA057),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildFirstName() {
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
                controller: firstNameController,
                keyboardType: TextInputType.name,
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
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'First Name',
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

  Widget _buildLastName() {
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(top: 30),
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
                controller: lastNameController,
                keyboardType: TextInputType.name,
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
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'Last Name',
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

  Widget _buildEmail() {
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(top: 30),
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
                  hintText: 'Email',
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
      padding: EdgeInsets.only(top: 30),
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
                  hintText: 'Password',
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

  Widget _buildConfirmPassword() {
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
                controller: confirmPasswordController,
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
                  hintText: 'Confirm Password',
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

  Widget _buildSignUpButton() {
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
              .emailSignUp(
                  emailController.text.trim(), passwordController.text, context)
              .whenComplete(
            () async {
              final User? user = FirebaseAuth.instance.currentUser;
              // DatabaseReference ref = FirebaseDatabase.instance.ref("users");
              // await ref.child(user!.uid).set(
              //   {
              //     "firstName": firstNameController.text.trim(),
              //     "lastName": lastNameController.text.trim(),
              //     "email": emailController.text.trim(),
              //     "password": firstNameController.text.trim(),
              //   },
              // );
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
          'Create an Account',
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

  Widget _buildLogin() {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
          (route) => false,
        ),
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: 'Log In',
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

  // Future login_service(String email, String password) async {
  //   Map data = {
  //     "username": email,
  //     "password": password,
  //   };
  //   var jsonData = null;
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var response = await http.post(
  //     Uri.parse(
  //         "https://vc-phase2-backend.herokuapp.com/login?username=$email&password=$password"),
  //     body: data,
  //   );
  //   if (response.statusCode == 200) {
  //     jsonData = json.decode(response.body);
  //     setState(
  //       () {
  //         _isLoading = false;
  //         print(jsonData['isValid']);
  //         if (jsonData['isValid']) {
  //           sharedPreferences.setBool("isValid", jsonData['isValid']);
  //           Navigator.pushAndRemoveUntil(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => Dashboard(),
  //               ),
  //               (route) => false);
  //         } else
  //           showDialog(
  //             context: context,
  //             builder: (context) => AlertDialog(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               title: Text(
  //                 'Invalid Login Credentials ! ',
  //                 style: TextStyle(
  //                   color: Colors.red,
  //                   fontFamily: 'Montserrat',
  //                 ),
  //               ),
  //               actions: [
  //                 ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Color(
  //                       0xFFF7B931B,
  //                     ),
  //                     onPrimary: Colors.white,
  //                   ),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text('Ok'),
  //                 )
  //               ],
  //             ),
  //           );
  //       },
  //     );
  //   } else {
  //     print(response.body);
  //   }
  // }
}
