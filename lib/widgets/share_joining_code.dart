import 'package:flutter/material.dart';

import 'package:share/share.dart';

Future<Widget> showShareInvitationBottomSheet(BuildContext context,String classId) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        height: mq.height * 0.1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.share),
              label: Text(
                'Share Invitation',
                style: const TextStyle(fontSize: 19),
              ),
              onPressed: () {
                Share.share('Join the classroom using code: $classId');
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ));
}