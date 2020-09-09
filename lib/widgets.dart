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

class TodoWidget extends StatelessWidget {
  final String text;
  final bool iscompleted;

  TodoWidget({this.text,@required this.iscompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color:  iscompleted ? Color(0xff7349ff): Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
                border: iscompleted ? null : Border.all(
                  color: Color(0xff868290),
                  width: 1.5,
                )
              ),
              child: Image(
                image:  AssetImage(
                  "assests/images/check_icon.png",
                ),
              ),
            ),
          ),
          Text(
            text ?? "{Unnamed To Do}",

          style: TextStyle(
            color: iscompleted ? Color(0xff211511): Color(0xff868290),
            fontSize: 16.0,
            fontWeight: iscompleted ?FontWeight.bold: FontWeight.w500,
          ),
          ),
        ],
      ),
    );

  }
}

class NoGlowBehavior extends ScrollBehavior{
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget Child, AxisDirection axisDirection){
    return Child;
  }
}

