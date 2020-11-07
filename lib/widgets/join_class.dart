import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utility/database.dart';

TextEditingController _codeController = TextEditingController();
bool isClassCodeValid = false;

Future<Widget> buildJoinClass(BuildContext context) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
    isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      context: context,
      builder: (ctx) => Container(
            height: mq.height*0.8,
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
                      'Join class',
                      style: TextStyle(fontSize: 18),
                    ),
                    FlatButton(
                      child: Text(
                        'Join',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: isClassCodeValid == false
                          ? null
                          : () async {
                              User user = FirebaseAuth.instance.currentUser;

                              DocumentSnapshot snapshot =
                                  await FirebaseFirestore.instance
                                      .collection('singleClass')
                                      .doc(_codeController.text)
                                      .get();
                              joinClassOnFirebase(
                                  _codeController.text,
                                  snapshot.data()['name'],
                                  snapshot.data()['section'],
                                  snapshot.data()['subject'],
                                  user.uid,
                                  user.displayName,
                                  user.photoURL);
                              _codeController.clear();
                            },
                    )
                  ],
                ),
                Center(
                  //padding: EdgeInsets.all(5),
                  child: Text(
                    'Ask your teacher for the class code, then enter\nit here.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                buildClassCodeField(mq.width * 0.93)
              ],
            ),
          ));
}

Widget buildClassCodeField(double width) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    width: width,
    child: TextField(
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        labelText: 'Class code',
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 1, color: Colors.blue),
        ),
      ),
      controller: _codeController,
      onChanged: (_value) {
        if (_value.length > 5) {
          isClassCodeValid = true;
        }
      },
    ),
  );
}
