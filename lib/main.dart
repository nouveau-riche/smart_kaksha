import 'package:collage_classroom/screens/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vxstate/vxstate.dart';

import './screens/authentication.dart';
import './screens/home_page.dart';
import '././vx_store.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(VxState(store: MyStore(),child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser != null
          ? HomePage()
          : SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        './authentication_screen': (ctx) => Authentication(),
        '/home-page': (ctx) => HomePage(),
      },
    );
  }
}
