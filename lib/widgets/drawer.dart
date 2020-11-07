import 'package:flutter/material.dart';

Widget buildDrawerContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Text(
          'Collage Classroom',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      Divider(
        color: Colors.grey,
      ),
      FlatButton.icon(
        icon: Icon(Icons.home),
        label: Text('Classes'),
        onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home-page', (route) => false);
        },
      ),
      FlatButton.icon(
        icon: Icon(Icons.calendar_today),
        label: Text('Calendar'),
        onPressed: () {},
      ),
      Divider(
        color: Colors.grey,
      ),
      FlatButton.icon(
        icon: Icon(Icons.calendar_today),
        label: Text('Classroom folders'),
        onPressed: () {},
      ),
      FlatButton.icon(
        icon: Icon(Icons.calendar_today),
        label: Text('Settings'),
        onPressed: () {},
      ),
      FlatButton.icon(
        icon: Icon(Icons.calendar_today),
        label: Text('Help'),
        onPressed: () {},
      ),
    ],
  );
}
