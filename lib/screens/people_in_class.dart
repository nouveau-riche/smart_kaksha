import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_page/components/drawer.dart';

class PeopleInClass extends StatelessWidget {
  final String classId;
  final String className;

  PeopleInClass(this.classId, this.className);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          className,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
      drawer: Drawer(
        child: BuildDrawer(),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('singleClass')
              .doc(classId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final _data = snapshot.data;

              List<Widget> allMembers = [];

              _data['studentJoined'].forEach((doc) {
                allMembers
                    .add(member(doc['studentName'], doc['studentImageUrl']));
              });

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: const Text(
                      'Instructor',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Divider(),
                  member(_data['instructor'], _data['photoUrl']),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: const Text(
                      'Classmates',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) => allMembers[index],
                    itemCount: allMembers.length,
                  ),
                ],
              );
            } else {
              return Text('nikunj');
            }
          }),
    );
  }

  Widget member(String name, String photoUrl) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            backgroundImage: NetworkImage(photoUrl),
          ),
          const SizedBox(width: 14),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
