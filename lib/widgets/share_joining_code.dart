import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:share/share.dart';
import '../utility/database.dart';

Future<Widget> showShareInvitationBottomSheet(
    BuildContext context, String classId) async {
  return await showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
            child: Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.share, color: Colors.blue),
                    label: const Text(
                      'Share Invitation',
                      style: const TextStyle(fontSize: 19),
                    ),
                    onPressed: () {
                      Share.share('Join the classroom using code: $classId');
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton.icon(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                    label: const Text(
                      'Delete Class',
                      style: const TextStyle(fontSize: 19),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDeleteAlert(context, classId);
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
          ));
}

showDeleteAlert(BuildContext context, String classId) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            title: const Text(
              'Delete Class',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            content: const Text(
              "By doing this, you'll no longer be\nable to see the class or participate\nin it.",
              style: const TextStyle(color: Colors.black87),
            ),
            actions: [
              FlatButton(
                child: const Text(
                  'CANCEL',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text(
                  'DELETE',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  User user = FirebaseAuth.instance.currentUser;
                  deleteCreatedClass(uid: user.uid, classId: classId);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}
