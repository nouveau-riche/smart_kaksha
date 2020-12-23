import 'package:flutter/material.dart';

import './create_class.dart';
import './join_class.dart';

buildBottomSheet(BuildContext context) async {
  return await showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2), topRight: Radius.circular(2))),
      context: context,
      builder: (context) => Container(
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
                SizedBox(
                  height: 14,
                )
              ],
            ),
          ));
}
