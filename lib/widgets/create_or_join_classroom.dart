import 'package:flutter/material.dart';

import './create_class.dart';
import './join_class.dart';

Future<Widget> buildBottomSheet(BuildContext context) async {
  return await showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      context: context,
      builder: (context) => Expanded(
        child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  FlatButton(
                    child: const Text(
                      'Create Class',
                      style: const TextStyle(fontSize: 19),
                    ),
                    onPressed: () {
                      buildCreateClass(context);
                    },
                  ),
                  FlatButton(
                    child: const Text(
                      'Join Class',
                      style: const TextStyle(fontSize: 19),
                    ),
                    onPressed: () {
                      buildJoinClass(context);
                    },
                  ),
                  SizedBox(height: 14,)
                ],
              ),
            ),
      ));
}
