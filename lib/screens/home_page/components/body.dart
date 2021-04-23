import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:collage_classroom/screens/home_page/components/display_class.dart';

class Body extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(left: 100),
              height: 70,
              child: Image.asset(
                "assets/images/blinking-arrow.gif",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
