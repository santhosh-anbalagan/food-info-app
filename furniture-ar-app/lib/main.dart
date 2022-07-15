import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'
    show ArCoreController;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture/services/auth.dart';
import 'package:furniture/services/wrapper.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('ARCORE IS AVAILABLE?');
  print(await ArCoreController.checkArCoreAvailability());
  print('\nAR SERVICES INSTALLED?');
  print(await ArCoreController.checkIsArCoreInstalled());
  runApp(
    StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(), //MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
