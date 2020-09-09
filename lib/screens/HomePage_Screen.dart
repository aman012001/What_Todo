import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/screens/Task_Screen.dart';
import 'package:todo/widgets.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  DatabaseHelper _dbHelper = DatabaseHelper();

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 32,
                    bottom:32,
                  ),
                  child: Image(
                    image: AssetImage(
                        'assests/images/logo.png'
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getListofTasks(),
                    builder: (context, snapshot){
                      return ScrollConfiguration(
                        behavior: NoGlowBehavior(),
                        child: ListView.builder(
                            itemCount:  snapshot.data.length,
                            itemBuilder: (context, index){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=> Taskpage(
                                      task: snapshot.data[index],
                                    )
                                  )
                                  );
                                },
                                child: TaskCard(
                                  title: snapshot.data[index].title,
                                ),
                              );
                            }
                        ),
                      );
                    },
                  ),
                ),
                  ],
                ),
                Positioned(
                  bottom: 24.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>Taskpage(task: null,)))
                          .then((value){
                        setState((){});
                       });
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          colors: [Color(0xff7349fe),Color(0xff643fdb)],
                          begin: Alignment(0.0,-1.0),
                          end: Alignment(0.0,1.0),
                        )
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
