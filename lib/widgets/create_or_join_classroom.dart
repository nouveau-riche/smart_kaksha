import 'package:flutter/material.dart';

import './create_class.dart';
import './join_class.dart';

Future<Widget> buildBottomSheet(BuildContext context) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      context: context,
      builder: (context) => Container(
            height: mq.height * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton(
                  child: const Text(
                    'Join Class',
                    style: const TextStyle(fontSize: 19),
                  ),
                  onPressed: () {
                    buildJoinClass(context);
                  },
                ),
                FlatButton(
                  child: const Text(
                    'Create Class',
                    style: const TextStyle(fontSize: 19),
                  ),
                  onPressed: () {
                    buildCreateClass(context);
                  },
                ),
              ],
            ),
          ));
}
