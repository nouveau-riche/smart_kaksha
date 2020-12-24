import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';

import '../utility/database.dart';

File file;
String fileName;
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
            child: BottomSheetContent(
              uid: uid,
              classId: classId,
              studentName: studentName,
              studentPhotoUrl: studentPhotoUrl,
              isInstructor: isInstructor,
            ),
          ));
}

class BottomSheetContent extends StatefulWidget {
  final String uid;
  final String classId;
  final String studentName;
  final String studentPhotoUrl;
  final bool isInstructor;

  BottomSheetContent(
      {this.uid,
      this.classId,
      this.studentName,
      this.studentPhotoUrl,
      this.isInstructor});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAppbar(
            context, widget.uid, widget.classId, widget.studentName, widget.studentPhotoUrl, widget.isInstructor),
        buildAddAttachment(),
        const Divider(
          color: Colors.black54,
        ),
        buildAddMessage(widget.uid),
        const Divider(
          color: Colors.black54,
        ),
      ],
    );
  }

  Widget buildAppbar(BuildContext context, String uid, String classId,
      String studentName, String photoUrl, bool isInstructor) {
    return AppBar(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
          postId = Uuid().v4();
          _assignmentController.clear();
          file = null;
          fileName = null;
        },
      ),
      actions: [
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: const Text(
            'Post',
            style: const TextStyle(fontSize: 16),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
            if (file == null) {
              return;
            }
            String downloadUrl = await uploadAssignmentOnFirebaseStorage(
                postId: postId, file: file);

            updateAssignmentInClass(
                uid: uid,
                classId: classId,
                assignmentName: _assignmentController.text,
                url: downloadUrl,
                studentName: studentName,
                studentPhotoUrl: photoUrl,
                isInstructor: isInstructor);
            postId = Uuid().v4();
            _assignmentController.clear();
            fileName = null;
            file = null;
          },
        ),
      ],
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
                label: fileName == null
                    ? const Text(
                        'Add attachment',
                        style: const TextStyle(color: Colors.black87),
                      )
                    : Text(
                        fileName,
                        style: const TextStyle(color: Colors.black87),
                      ),
                icon: const Icon(Icons.attachment),
                onPressed: () async {
                  result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    file = File(result.files.single.path);
                    setState(() {
                      fileName = basename(file.path);
                    });
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
}
