import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/Task_Screen.dart';
import 'package:todo/widgets.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            color: Color(0xFFf6f6f6),
            width: double.infinity,
            padding: EdgeInsets.all(24.0),
            child: Stack(
              children: [
                Expanded(
                  child: ListView(
                    children: [ Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                        image: AssetImage(
                            'assests/images/logo.png'
                        ),
                       ),
                        TaskCard(),
                        TaskCard(),
                        TaskCard(),
                        TaskCard(),
                        TaskCard(),
                        TaskCard(),
                      ]
                     ),
                    ]
                  ),
                ),
                Positioned(
                  bottom: 24.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>Taskpage(),
                      ));
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xff7349fe),
                      ),
                      child: Image(
                        image: AssetImage(
                          "assests/images/add_icon.png",
                        ),
                      ),
                    ),
                  ),
                )
             ]
            ),
          ),
        )
    );
  }
}
