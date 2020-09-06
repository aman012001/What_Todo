import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String desc;
  TaskCard({this.title,this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 18.0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 18.0,

        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text(
          title ?? "Unamed Task",
          style: TextStyle(
            color: Color(0xff211551),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
                desc?? "Hello User Welcome to what_todo app, this is just a default task that you can edit or delete the task",
                style: TextStyle(
                  color: Color(0xff868290),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )
            ),
          ),
        ]
      ),
    );
  }
}
