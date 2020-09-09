import 'package:flutter/material.dart';
import 'package:todo/Models/Task.dart';
import 'package:todo/Models/todo.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/widgets.dart';

class Taskpage extends StatefulWidget {

  final Task task;
  Taskpage({@required this.task});
  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  DatabaseHelper _dbhelper = DatabaseHelper();
  String _taskTitle = "";
  int _taskId = 0;

  @override
  void initState() {
    // TODO: implement initState
    if(widget.task!=null){
      _taskTitle = widget.task.title;
      _taskId = widget.task.id;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.0,
                    bottom: 6.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          },
                        child: Image(
                          image: AssetImage(
                            "assests/images/back_arrow_icon.png"
                          ),
                        ),
                      ),
                      ),
                      Expanded(
                          child: new ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 100.0,
                            ),
                            child: TextField(
                              onSubmitted:(value) async {
                                // check if the field is not empty
                                if(value!=""){
                                  // check if the field is null
                                  if(widget.task==null){

                                    Task newTask = Task(
                                      title: value,
                                    );

                                    await _dbhelper.insertTask(newTask);

                                    print("Task has been Cretaed");
                                  } else{
                                    print("Update the existing task");
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Task Title",
                                border: InputBorder.none,

                              ),
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF211551)
                              ),
                              controller: TextEditingController()..text = _taskTitle,
                            ),
                          ),
                      ),
                    ],
                  ),

                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Description for the Task...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      )
                    ),
                  ),
                ),
                FutureBuilder(
                  initialData: [],
                  future: _dbhelper.getListofTodos(_taskId),
                  builder: (context, snapshot){
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                // Switch the Todo completion state
                              },
                              child: TodoWidget(
                                text: snapshot.data[index].title,
                                iscompleted: snapshot.data[index].isDone == 0 ? false: true,
                              ),
                            );
                          }
                      ),
                    );
                  }
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        margin: EdgeInsets.only(
                          right: 12.0,
                        ),
                        decoration: BoxDecoration(
                            color:  Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
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
                      Expanded(
                          child: TextField(
                            onSubmitted: (value) async{
                              if(value!=""){
                                // check if the field is null
                                if(widget.task!=null){

                                  Todo newTodo = Todo(
                                    title: value,
                                    isDone: 0,
                                    taskId: widget.task.id,
                                  );
                                  await _dbhelper.insertTodo(newTodo);
                                  print("Todo has been Cretaed");
                                  setState((){});
                                }
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Enter Todo Item",
                              border: InputBorder.none,
                            ),

                      )),
                   ],
                  ),
                )
              ],
            ),
              Positioned(
                bottom: 24.0,
                right: 24.0,
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
                      color: Color(0xfffe3577),
                    ),
                    child: Image(
                      image: AssetImage(
                        "assests/images/delete_icon.png",
                      ),
                    ),
                  ),
                ),
              ),
          ]
          )
        ),
      ),
    );
  }
}
