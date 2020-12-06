import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/authentication.dart';
import './screens/home_page.dart';

void main() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser != null ? HomePage() : Authentication(),
    debugShowCheckedModeBanner: false,
      routes: {
        './authentication_screen': (ctx) => Authentication(),
        '/home-page': (ctx) => HomePage(),
      },
    );
  }
}
