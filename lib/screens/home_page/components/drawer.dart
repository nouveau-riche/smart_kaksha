import 'package:collage_classroom/constants.dart';
import 'package:collage_classroom/screens/home_page/home_page.dart';
import 'package:collage_classroom/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../settings.dart';
import '../../../utility/google_signin.dart';

class BuildDrawer extends StatelessWidget {

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 20, bottom: 8),
          child: const Text(
            'Smart Kaksha',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TextButton.icon(
            icon: const Icon(
              Icons.school,
              size: 30,
              color: kPrimaryColor,
            ),
            label: const Text(
              'Classes',
              style: TextStyle(color: kTextColor),
            ),
            style: TextButton.styleFrom(primary: kSecondaryColor),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TextButton.icon(
            icon: const Icon(
              Icons.exit_to_app,
              size: 30,
              color: kPrimaryColor,
            ),
            label: const Text(
              'Logout',
              style: TextStyle(color: kTextColor),
            ),
            style: TextButton.styleFrom(primary: kSecondaryColor),
            onPressed: () {
              signOutGoogle();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => SplashScreen()),
                  (route) => false);
            },
          ),
        ),
      ],
    );
  }
}
