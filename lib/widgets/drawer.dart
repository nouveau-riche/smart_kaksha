import 'package:flutter/material.dart';

import '../screens/settings.dart';
import '../utility/google_signin.dart';

Widget buildDrawerContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 32, left: 20),
        child: const Text(
          'Collage Classroom',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      Divider(
        color: Colors.grey,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: FlatButton.icon(
          icon: const Icon(Icons.school),
          label: const Text('Classes'),
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home-page', (route) => false);
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: FlatButton.icon(
          icon: const Icon(Icons.settings),
          label: const Text('Settings'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Settings()));
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: FlatButton.icon(
          icon: const Icon(Icons.help),
          label: const Text(
            'Help',
          ),
          onPressed: () {},
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: FlatButton.icon(
          icon: const Icon(Icons.exit_to_app),
          label: const Text('Logout'),
          onPressed: () {
            signOutGoogle();
            Navigator.of(context).pushNamedAndRemoveUntil(
                './authentication_screen', (route) => false);
          },
        ),
      ),
      Divider(),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: FlatButton.icon(
          icon: const Icon(Icons.exit_to_app),
          label: const Text('Logout'),
          onPressed: () {
            signOutGoogle();
            Navigator.of(context).pushNamedAndRemoveUntil(
                './authentication_screen', (route) => false);
          },
        ),
      ),
    ],
  );
}
