import 'package:flutter/material.dart';

class ClassDetail extends StatelessWidget {
  final String className;
  final bool isInstructor;
  ClassDetail(this.className,this.isInstructor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [

        isInstructor ? IconButton(
          icon: Icon(Icons.settings),
          onPressed: (){},
        ) : IconButton(
          icon: Icon(Icons.description),
          onPressed: (){},
        ),
      ],),
        body: Column(children: [
          Container(
            child: Text(className),
          ),
        ],),
    );
  }
}
