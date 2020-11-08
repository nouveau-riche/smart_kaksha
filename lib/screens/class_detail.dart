import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_classroom/widgets/assign_assignment_to_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/display_class.dart';
import '../widgets/drawer.dart';
import '../widgets/assignment.dart';

class ClassDetail extends StatefulWidget {
  final String classId;
  final String className;
  final String section;
  final bool isInstructor;

  ClassDetail(this.classId, this.className, this.section, this.isInstructor);

  @override
  _ClassDetailState createState() => _ClassDetailState();
}

class _ClassDetailState extends State<ClassDetail> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          widget.isInstructor
              ? IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black54,
            ),
            onPressed: () {},
          )
              : IconButton(
            icon: Icon(
              Icons.description,
              color: Colors.black54,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: buildDrawerContent(context),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildClass(mq.height * 0.16, mq.width, widget.className,
              widget.section, widget.isInstructor),
          buildShareSomething(context, mq.height * 0.08),
          buildAssignmentStream(),
          buildBottomNavigationBar(mq.height * 0.1, mq.width * 0.5),
        ],
      ),
    );
  }

  buildAssignmentStream() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('assignments')
          .doc(widget.classId)
          .collection('allAssignments')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final _data = snapshot.data;
          List<Assignment> allAssignment = [];
          _data.docs.map((doc) {
            allAssignment.add(
                Assignment(
                  assignmentName: doc['assignmentName'],
                  isInstructor: doc['isInstructor'],
                  url: doc['url'],
                  studentName: doc['studentName'],
                timestamp: doc['timestamp'],)
            );
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

  buildBottomNavigationBar(double height, double width) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: width,
            child: IconButton(
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.assignment,
                color: index == 0 ? Colors.black : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
            ),
          ),
          Container(
            width: width,
            child: IconButton(
              splashColor: Colors.transparent,
              icon: Icon(Icons.people,
                  color: index == 1 ? Colors.black : Colors.white),
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShareSomething(BuildContext context, double height) {
    User user = FirebaseAuth.instance.currentUser;
    return InkWell(
      onTap: () {
        buildAssignAssignment(
            context: context,
            uid: user.uid,
            classId: widget.classId,
            studentName: user.displayName,
            isInstructor: widget.isInstructor);
      },
      child: Card(
        elevation: 8,
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
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
              SizedBox(width: 10),
              Text('Share Something with your class...'),
            ],
          ),
        ),
      ),
    );
  }
}
