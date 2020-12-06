import 'package:flutter/material.dart';

import '../screens/people_in_class.dart';
import '../screens/class_stream.dart';

class ClassDetail extends StatefulWidget {
  final String classId;
  final String className;
  final String section;
  final String subject;
  final bool isInstructor;

  ClassDetail(this.classId, this.className, this.section, this.subject,this.isInstructor);

  @override
  _ClassDetailState createState() => _ClassDetailState();
}

class _ClassDetailState extends State<ClassDetail> {
  PageController _controller;
  int pageIndex = 0;

  void selectPage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  onTapChangePage(int pageIndex) {
    _controller.animateToPage(pageIndex,
        duration: const Duration(microseconds: 400), curve: Curves.bounceInOut);
  }

  whenPageChanges(int index) {
    setState(() {
      this.pageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              ClassStreamScreen(widget.classId, widget.className,
                  widget.section, widget.subject,widget.isInstructor),
              PeopleInClass(widget.classId,widget.className)
            ],
            controller: _controller,
            onPageChanged: whenPageChanges,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onTapChangePage,
        items: [
          const BottomNavigationBarItem(
            icon: const Icon(Icons.assignment),
            title: const Text('Stream')
          ),
          const BottomNavigationBarItem(
            icon: const Icon(Icons.people),
            title: const Text('People'),
          ),
        ],
      ),
    );
  }
}
