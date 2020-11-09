import 'package:flutter/material.dart';

import '../utility/database.dart';


Future<Widget> showDeleteAssignmentBottomSheet(BuildContext context,String classId,String assignmentId) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        height: mq.height * 0.1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlatButton(
              child: Text(
                'Delete Assignment',
                style: const TextStyle(fontSize: 19),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                showDeleteAlert(context,classId,assignmentId);
              },
            ),
          ],
        ),
      ));
}

showDeleteAlert(BuildContext context,String classId,String assignmentId) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          'Delete',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        content: Text(
          "By doing this, the class and\ninstructor will no longer be\nable to see your assignment",
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          FlatButton(
            child: Text(
              'CANCEL',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              'DELETE',
              style: TextStyle(fontWeight: FontWeight.w500,color: Colors.redAccent),
            ),
            onPressed: () {
              deleteAssignment(classId, assignmentId);
              Navigator.of(context).pop();
            },
          ),
        ],
      ));
}
