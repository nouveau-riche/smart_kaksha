import 'package:flutter/material.dart';

import '../screens/class_detail.dart';

class DisplayClass extends StatelessWidget {
  final String classId;
  final String className;
  final String section;
  final bool isInstructor;

  DisplayClass({this.classId,this.className, this.section, this.isInstructor});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => ClassDetail(classId,className, section, isInstructor)));
        },
        child: buildClass(mq.height * 0.16, mq.width, className, section,isInstructor));
  }
}

Widget buildClass(
    double height, double width, String className, String section,bool isInstructor) {
  return Card(
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: isInstructor == true
                ? Image.asset("assets/images/instructor.jpeg",
                    fit: BoxFit.cover)
                : Image.asset("assets/images/joined.jpeg",
                    fit: BoxFit.cover),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    className,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.white, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
              Text(
                section,
                style: const TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
