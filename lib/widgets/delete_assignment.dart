import 'package:flutter/material.dart';

import '../utility/database.dart';

Future<Widget> showDeleteAssignmentBottomSheet(
    BuildContext context, String classId, String assignmentId) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
            height: mq.height * 0.1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  child: const Text(
                    'Delete Assignment',
                    style: const TextStyle(fontSize: 19),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDeleteAlert(context, classId, assignmentId);
                  },
                ),
              ],
            ),
          ));
}

showDeleteAlert(BuildContext context, String classId, String assignmentId) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            title: const Text(
              'Delete',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            content: const Text(
              "By doing this, the class and\ninstructor will no longer be\nable to see your assignment",
              style: const TextStyle(color: Colors.black87),
            ),
            actions: [
              TextButton(
                child: const Text(
                  'CANCEL',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'DELETE',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.redAccent),
                ),
                onPressed: () {
                  deleteAssignment(
                      classId: classId, assignmentId: assignmentId);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}
