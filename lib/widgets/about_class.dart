import 'package:flutter/material.dart';

Future<Widget> showAboutClassBottomSheet(BuildContext context, String className,
    String sectionName, String subject) async {
  final mq = MediaQuery.of(context).size;

  return await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      builder: (ctx) => Container(
            height: mq.height * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppBar(context),
                const Divider(
                  color: Colors.black54,
                ),
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
                            color: Colors.blue),
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
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.black54),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: 90),
        const Text(
          'About',
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    ),
  );
}
