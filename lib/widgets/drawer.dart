import 'package:flutter/material.dart';

import '../utility/google_signin.dart';

Widget buildDrawerContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 32,left: 20),
        child: Text(
          'Collage Classroom',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      Divider(
        color: Colors.grey,
      ),
      Padding(
        padding: EdgeInsets.only(left: 8),
        child: FlatButton.icon(
          icon: Icon(Icons.school),
          label: Text('Classes'),
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home-page', (route) => false);
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 8),
        child: FlatButton.icon(
          icon: Icon(Icons.settings),
          label: Text('Settings'),
          onPressed: () {},
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 8),
        child: FlatButton.icon(
          icon: Icon(Icons.help),
          label: Text('Help',),
          onPressed: () {},
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 8),
        child: FlatButton.icon(
          icon: Icon(Icons.exit_to_app),
          label: Text('Logout'),
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
