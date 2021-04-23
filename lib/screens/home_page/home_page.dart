import 'package:collage_classroom/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './components/body.dart';
import 'components/drawer.dart';
import '../../widgets/create_or_join_classroom.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Collage Classroom',
          style: const TextStyle(color: Colors.black54),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(user.photoURL),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: BuildDrawer(),
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        child: const Icon(Icons.add, size: 30),
        onPressed: () {
          return buildBottomSheet(context);
        },
      ),
    );
  }
}
