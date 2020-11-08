import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

import '../utility/database.dart';

File file;
String postId = Uuid().v4();
final _assignmentController = TextEditingController();

Future<Widget> buildAssignAssignment({BuildContext context, String uid,String classId,String studentName,bool isInstructor}) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      builder: (ctx) => Container(
            height: mq.height * 0.8,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppbar(context,uid,classId,studentName,isInstructor),
                buildAddAttachment(),
                Divider(
                  color: Colors.black54,
                ),
                buildAddMessage(uid),
                Divider(
                  color: Colors.black54,
                ),
              ],
            ),
          ));
}

Widget buildAppbar(BuildContext context,String uid,String classId,String studentName,bool isInstructor) {
  return Card(
    elevation: 6,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15))),
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text('Post'),
            onPressed: () async {
              Navigator.of(context).pop();
              String downloadUrl = await uploadAssignmentOnFirebaseStorage(postId, file);
              updateAssignmentInClass(uid,classId,_assignmentController.text,downloadUrl,studentName,isInstructor);
              postId = Uuid().v4();
              _assignmentController.clear();
            },
          ),
        ],
      ),
    ),
  );
}

Widget buildAddAttachment() {
  FilePickerResult result;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      FlatButton.icon(
        label: Text(
          'Add attachment',
          style: TextStyle(color: Colors.black87),
        ),
        icon: Icon(Icons.attachment),
        onPressed: () async {
          result = await FilePicker.platform.pickFiles();
          if (result != null) {
            file = File(result.files.single.path);
          } else {
            // User canceled the picker
          }
        },
      ),
      Icon(Icons.done,color: result != null ? Colors.green : Colors.white)
    ],
  );
}

buildAddMessage(String uid) {
  return Row(
    children: [
      SizedBox(
        width: 10,
      ),
      Icon(Icons.subject),
      SizedBox(
        width: 10,
      ),
      Container(
          width: 200,
          child: TextField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              hintText: 'Share with your class',
              hintStyle: TextStyle(color: Colors.black87),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
            controller: _assignmentController,
          )),
    ],
  );
}
