import 'package:collage_classroom/constants.dart';
import 'package:flutter/material.dart';

import './create_class.dart';
import './join_class.dart';

buildBottomSheet(BuildContext context) async {
  return await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2), topRight: Radius.circular(2)),),
      context: context,
      builder: (context) => Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                TextButton(
                  child: const Text(
                    'Create Class',
                    style: const TextStyle(fontSize: 18, color: kTextColor),
                  ),
                  onPressed: () {
                    buildCreateClass(context);
                  },
                ),
                TextButton(
                  child: const Text(
                    'Join Class',
                    style: const TextStyle(fontSize: 18, color: kTextColor),
                  ),
                  onPressed: () {
                    buildJoinClass(context);
                  },
                ),
                const SizedBox(
                  height: 14,
                )
              ],
            ),
          ));
}
