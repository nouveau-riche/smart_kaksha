import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utility/database.dart';

TextEditingController _className;
TextEditingController _secName;
TextEditingController _subjectName;

Future<Widget> buildEditClass(BuildContext context, String classId,
    String className, String section, String subject) async {
  _className = TextEditingController(text: className);
  _secName = TextEditingController(text: section);
  _subjectName = TextEditingController(text: subject);

  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      builder: (ctx) => Container(
            height: mq.height * 0.8,
            child: Column(
              children: [
                buildAppBar(context, classId),
                buildClassNameField(mq.width * 0.9),
                buildSecNameField(mq.width * 0.9),
                buildSubjectNameField(mq.width * 0.9),
              ],
            ),
          ));
}

Widget buildAppBar(BuildContext context, String classId) {
  return AppBar(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15))),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(
        Icons.clear,
        color: Colors.black54,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    title: const Text(
      'Edit class',
      style: const TextStyle(fontSize: 18, color: Colors.black54),
    ),
    actions: [
      TextButton(
        child: const Text(
          'Edit',
          style: const TextStyle(fontSize: 16),
        ),
        onPressed: () {
          User user = FirebaseAuth.instance.currentUser;
          editClassroomDetails(
              uid: user.uid,
              classId: classId,
              section: _secName.text,
              name: _className.text,
              subject: _subjectName.text);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      )
    ],
  );
}

Widget buildClassNameField(double width) {
  return Container(
    width: width,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: TextField(
      cursorColor: Colors.blue,
      decoration: const InputDecoration(
        hintText: 'Class name',
        labelText: 'Class name',
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.blue),
        ),
      ),
      autofocus: true,
      controller: _className,
    ),
  );
}

Widget buildSecNameField(double width) {
  return Container(
    width: width,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: TextField(
      decoration: const InputDecoration(
        hintText: 'Section',
        labelText: 'Section',
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.blue),
        ),
      ),
      controller: _secName,
    ),
  );
}

Widget buildSubjectNameField(double width) {
  return Container(
    width: width,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: TextField(
      cursorColor: Colors.blue,
      decoration: const InputDecoration(
        hintText: 'Subject',
        labelText: 'Subject',
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.blue),
        ),
      ),
      autofocus: true,
      controller: _subjectName,
    ),
  );
}
