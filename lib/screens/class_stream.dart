import 'package:collage_classroom/widgets/edit_class.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_classroom/widgets/share_assignment_to_class.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/display_class.dart';
import '../widgets/drawer.dart';
import '../widgets/assignment.dart';
import '../widgets/about_class.dart';

class ClassStreamScreen extends StatelessWidget{

  final String classId;
  final String className;
  final String section;
  final String subject;
  final bool isInstructor;

  ClassStreamScreen(this.classId, this.className, this.section, this.subject,this.isInstructor);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          isInstructor
              ? IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black54,
            ),
            onPressed: () {
              buildEditClass(context,classId,className,section,subject);
            },
          )
              : IconButton(
            icon: const Icon(
              Icons.description,
              color: Colors.black54,
            ),
            onPressed: () {
              showAboutClassBottomSheet(context, className, section, subject);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: buildDrawerContent(context),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildClass(context,mq.height * 0.16, mq.width, classId,className,
              section, isInstructor),
          buildShareSomething(context, mq.height * 0.08),
          buildAssignmentStream(),
        ],
      ),
    );
  }

  Widget buildShareSomething(BuildContext context, double height) {
    User user = FirebaseAuth.instance.currentUser;
    return InkWell(
      onTap: () {
        buildShareAssignment(
            context: context,
            uid: user.uid,
            classId: classId,
            studentName: user.displayName,
            studentPhotoUrl: user.photoURL,
            isInstructor: isInstructor);
      },
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(user.photoURL),
              ),
              const SizedBox(width: 10),
              const Text(
                'Share Something with your class...',
                style: const TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildAssignmentStream() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('assignments')
          .doc(classId)
          .collection('allAssignments')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final _data = snapshot.data;
          List<Assignment> allAssignment = [];
          _data.docs.map((doc) {
            allAssignment.add(Assignment(
              classId: classId,
              assignmentId: doc['assignmentId'],
              uid: doc['uid'],
              assignmentName: doc['assignmentName'],
              isInstructor: doc['isInstructor'],
              url: doc['url'],
              photoUrl: doc['photoUrl'],
              studentName: doc['studentName'],
              timestamp: doc['timestamp'],
            ));
          }).toList();
          return Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
                itemBuilder: (ctx, index) => allAssignment[index],
                itemCount: allAssignment.length),
          );
        } else {
          return Text('nikunj');
        }
      },
    );
  }

}