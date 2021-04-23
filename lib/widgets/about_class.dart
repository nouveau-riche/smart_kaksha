import 'package:collage_classroom/constants.dart';
import 'package:flutter/material.dart';

Future<Widget> showAboutClassBottomSheet(BuildContext context, String className,
    String sectionName, String subject) async {
  final mq = MediaQuery.of(context).size;

  return await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(18), topLeft: Radius.circular(18))),
      builder: (ctx) => Container(
            height: mq.height * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppBar(context),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        className,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        sectionName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SUBJECT',
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            subject,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
}

Widget buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15))),
    centerTitle: true,
    title: const Text(
      'About',
      style: const TextStyle(color: Colors.black87),
    ),
    leading: IconButton(
      icon: const Icon(Icons.clear, color: Colors.black54),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}
