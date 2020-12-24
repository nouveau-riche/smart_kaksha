import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/delete_assignment.dart';

class Assignment extends StatelessWidget {
  final String classId;
  final String assignmentId;
  final String uid;
  final String studentName;
  final String assignmentName;
  final String url;
  final String photoUrl;
  final bool isInstructor;
  final Timestamp timestamp;

  Assignment(
      {this.classId,
      this.assignmentId,
      this.uid,
      this.assignmentName,
      this.url,
      this.studentName,
      this.photoUrl,
      this.isInstructor,
      this.timestamp});

  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          Fluttertoast.showToast(msg: 'Cannot open');
        }
      },
      child: Card(
          elevation: 8,
          margin: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: isInstructor
              ? buildAssignmentPostedByInstructor(mq.height * 0.1)
              : buildAssignmentPostedByStudent(context, mq.height * 0.1)),
    );
  }

  Widget buildAssignmentPostedByInstructor(double height) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.green,
            backgroundImage: NetworkImage(photoUrl),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 270,
                child: Text(
                  'New Assignment Posted: $assignmentName',
                  overflow: TextOverflow.fade,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(timeAgo.format(timestamp.toDate()),
                  style: const TextStyle(color: Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAssignmentPostedByStudent(BuildContext context, double height) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(photoUrl),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      Text(
                        timeAgo.format(timestamp.toDate()),
                        style: const TextStyle(color: Colors.black87),
                      )
                    ],
                  ),
                ],
              ),
              if (user.uid == uid)
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    showDeleteAssignmentBottomSheet(
                        context, classId, assignmentId);
                  },
                ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              assignmentName,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
