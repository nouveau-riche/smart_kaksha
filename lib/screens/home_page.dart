import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/display_class.dart';
import '../widgets/drawer.dart';
import '../widgets/create_or_join_classroom.dart';

class HomePage extends StatelessWidget {
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
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(user.photoURL),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: buildDrawerContent(context),
      ),
      body: stream(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 30),
        onPressed: () {
          return buildBottomSheet(context);
        },
      ),
    );
  }

  Widget stream() {
    User user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('classesCreated')
            .doc(user.uid)
            .collection('allClasses')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final _data = snapshot.data;

            List<DisplayClass> classes = [];
            _data.docs.map((doc) {
              classes.add(DisplayClass(
                classId: doc['class_id'],
                className: doc['name'],
                section: doc['section'],
                subject: doc['subject'],
                isInstructor: doc['isInstructor'],
              ));
            }).toList();

            if (classes.length == 0) {
              return buildNoClass();
            }

            return ListView.builder(
              itemBuilder: (ctx, index) => classes[index],
              itemCount: classes.length,
            );
          } else {
            return buildNoClass();
          }
        });
  }

  Widget buildNoClass() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            height: 380,
            child: Image.asset(
              "assets/images/no-class.png",
            )),
        const Text(
          "Don't see your existing classes?",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        const SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Create or join your first class'),
            Container(
                padding: const EdgeInsets.only(left: 110),
                height: 70,
                child: Image.asset(
                  "assets/images/blinking-arrow.gif",
                )),
          ],
        ),
      ],
    );
  }
}
