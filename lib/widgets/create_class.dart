import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utility/database.dart';

TextEditingController _className = TextEditingController();
TextEditingController _secName = TextEditingController();
TextEditingController _subjectName = TextEditingController();

bool isSubjectNameValid = false;
bool isClassNameValid = false;
bool isSectionNameValid = false;

Future<Widget> buildCreateClass(BuildContext context) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      builder: (ctx) => Container(
            height: mq.height,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      'Create class',
                      style: TextStyle(fontSize: 18),
                    ),
                    FlatButton(
                      child: Text(
                        'Create',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: isSubjectNameValid == false ||
                              isClassNameValid == false ||
                              isSectionNameValid == false
                          ? null
                          : () {
                              User user = FirebaseAuth.instance.currentUser;
                              saveClassOnFirebase(
                                  user.uid,
                                  _className.text,
                                  _secName.text,
                                  _subjectName.text,
                                  user.displayName,
                                  true);
                              Navigator.of(context).pop();
                              _className.clear();
                              _secName.clear();
                              _subjectName.clear();
                            },
                    )
                  ],
                ),
                buildClassNameField(mq.width * 0.9),
                buildSecNameField(mq.width * 0.9),
                buildSubjectNameField(mq.width * 0.9),
              ],
            ),
          ));
}

Widget buildClassNameField(double width) {
  return Container(
    width: width,
    child: TextField(
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        hintText: 'Class name',
        labelText: 'Class name',
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.blue),
        ),
      ),
      autofocus: true,
      controller: _className,
      onChanged: (_value) {
        if (_value.length > 0) {
          isClassNameValid = true;
        }
      },
    ),
  );
}

Widget buildSecNameField(double width) {
  return Container(
    width: width,
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Section',
        labelText: 'Section',
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.blue),
        ),
      ),
      controller: _secName,
      onChanged: (_value) {
        if (_value.length > 0) {
          isSectionNameValid = true;
        }
      },
    ),
  );
}

Widget buildSubjectNameField(double width) {
  return Container(
    width: width,
    child: TextField(
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        hintText: 'Subject',
        labelText: 'Subject',
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.blue),
        ),
      ),
      autofocus: true,
      controller: _subjectName,
      onChanged: (_value) {
        if (_value.length > 0) {
          isSubjectNameValid = true;
        }
      },
    ),
  );
}
