import 'package:flutter/material.dart';

import './create_class.dart';
import './join_class.dart';

Future<Widget> buildBottomSheet(BuildContext context) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      context: context,
      builder: (context) => Container(
            height: mq.height * 0.16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton(
                  child: const Text(
                    'Join Class',
                    style: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    buildJoinClass(context);
                  },
                ),
                FlatButton(
                  child: const Text(
                    'Create Class',
                    style: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    buildCreateClass(context);
                  },
                ),
              ],
            ),
          ));
}


