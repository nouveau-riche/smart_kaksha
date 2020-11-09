import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

import '../utility/database.dart';

File file;
String postId = Uuid().v4();
final _assignmentController = TextEditingController();

Future<Widget> buildShareAssignment(
    {BuildContext context,
    String uid,
    String classId,
    String studentName,
    String studentPhotoUrl,
    bool isInstructor}) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15))),
      builder: (ctx) => Container(
            height: mq.height * 0.8,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppbar(context, uid, classId, studentName, studentPhotoUrl,
                    isInstructor),
                buildAddAttachment(),
                const Divider(
                  color: Colors.black54,
                ),
                buildAddMessage(uid),
                const Divider(
                  color: Colors.black54,
                ),
              ],
            ),
          ));
}

Widget buildAppbar(BuildContext context, String uid, String classId,
    String studentName, String photoUrl, bool isInstructor) {
  return Card(
    elevation: 6,
    shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15))),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              Navigator.of(context).pop();
              postId = Uuid().v4();
              _assignmentController.clear();
              file = null;
            },
          ),
          RaisedButton(
            color: Colors.blue,
            child: const Text(
              'Post',
              style: const TextStyle(fontSize: 16),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              if (file == null) {
                return;
              }
              String downloadUrl =
                  await uploadAssignmentOnFirebaseStorage(postId, file);

              updateAssignmentInClass(uid, classId, _assignmentController.text,
                  downloadUrl, studentName, photoUrl, isInstructor);
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
      result != null
          ? Text(result.files.single.path)
          : FlatButton.icon(
              label: const Text(
                'Add attachment',
                style: const TextStyle(color: Colors.black87),
              ),
              icon: const Icon(Icons.attachment),
              onPressed: () async {
                result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  file = File(result.files.single.path);
                } else {
                  // User canceled the picker
                }
              },
            ),
      Icon(Icons.done, color: result != null ? Colors.green : Colors.white)
    ],
  );
}

buildAddMessage(String uid) {
  return Row(
    children: [
      const SizedBox(
        width: 10,
      ),
      const Icon(Icons.subject),
      const SizedBox(
        width: 10,
      ),
      Container(
          width: 200,
          child: TextField(
            cursorColor: Colors.grey,
            decoration: const InputDecoration(
              hintText: 'Share with your class',
              hintStyle: const TextStyle(color: Colors.black87),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white)),
            ),
            controller: _assignmentController,
          )),
    ],
  );
}
