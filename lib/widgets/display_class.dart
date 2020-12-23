import 'package:flutter/material.dart';

import '../screens/class_detail.dart';
import '../widgets/unenrol_joined_class.dart';
import '../widgets/share_joining_code.dart';

class DisplayClass extends StatelessWidget {
  final String classId;
  final String className;
  final String section;
  final String subject;
  final bool isInstructor;

  DisplayClass({this.classId,this.className, this.section, this.subject,this.isInstructor});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => ClassDetail(classId,className, section, subject,isInstructor)));
        },
        child: buildClass(context,mq.height * 0.16, mq.width, classId,className, section,isInstructor));
  }
}

Widget buildClass(BuildContext context,
    double height, double width, String classId, String className, String section,bool isInstructor) {
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
                    onPressed: isInstructor ? (){
                      showShareInvitationBottomSheet(context, classId);
                    } : () {
                        showUnEnrolBottomSheet(context,classId);
                    },
                  ),
                ],
              ),
              Text(
                section,
                style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
