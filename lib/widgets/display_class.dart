import 'package:flutter/material.dart';

import '../screens/class_detail.dart';

class DisplayClass extends StatelessWidget{
  final String className;
  final String section;
  final bool isInstructor;
  DisplayClass({this.className,this.section,this.isInstructor});

  @override
  Widget build(BuildContext context){
    final mq = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ClassDetail(className,isInstructor)));
      },
      child: buildClass(mq.height*0.2)
    );
  }

  Widget buildClass(double height){
    return  Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14),),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        height: height,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(className,style: TextStyle(fontSize: 20,color: Colors.white),),
                IconButton(
                  icon: Icon(Icons.more_horiz,color: Colors.white,size: 28),
                  onPressed: (){},
                ),
              ],
            ),
            Text(section,style: TextStyle(fontSize: 18,color: Colors.white),),
          ],
        ),
      ),
    );
  }

}