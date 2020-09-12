import 'dart:async';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/screens/Task_Screen.dart';
import 'package:todo/widgets.dart';
import 'package:highlighter_coachmark/highlighter_coachmark.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  GlobalKey _fabKey = GlobalObjectKey("fab");
  GlobalKey _buttonKey = GlobalObjectKey("button");
  DatabaseHelper _dbHelper = DatabaseHelper();

  SuperTooltip tooltip;

//  Future<bool> _willPopCallback() async {
//    // If the tooltip is open we don't pop the page on a backbutton press
//    // but close the ToolTip
//    if (tooltip.isOpen) {
//      tooltip.close();
//      return false;
//    }
//    return true;
//  }
//
//  void onTap() {
//    if (tooltip != null && tooltip.isOpen) {
//      tooltip.close();
//      return;
//    }
//
//    RenderBox renderBox = context.findRenderObject();
//    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
//
//    var targetGlobalCenter = renderBox
//        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);
//
//    // We create the tooltip on the first use
//    tooltip = SuperTooltip(
//      popupDirection: TooltipDirection.left,
//      arrowTipDistance: 15.0,
//      arrowBaseWidth: 40.0,
//      arrowLength: 40.0,
//      borderColor: Colors.green,
//      borderWidth: 5.0,
//      snapsFarAwayVertically: true,
//      showCloseButton: ShowCloseButton.inside,
//      hasShadow: false,
//      touchThrougArea: new Rect.fromLTWH(targetGlobalCenter.dx - 100,
//          targetGlobalCenter.dy - 100, 200.0, 160.0),
//      touchThroughAreaShape: ClipAreaShape.rectangle,
//      content: new Material(
//          child: Padding(
//        padding: const EdgeInsets.only(top: 20.0),
//        child: Text(
//          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
//          "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, "
//          "sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ",
//          softWrap: true,
//        ),
//      )),
//    );
//
//    tooltip.show(context);
//  }




@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          key: _buttonKey, // setting key
          onPressed: showFAB,
          child: Text("RaisedButton"),
        ),
      ),

//        body: SafeArea(
//          child: Container(
//            color: Color(0xFFf6f6f6),
//            width: double.infinity,
//            padding: EdgeInsets.all(24.0),
//            child: Stack(children: [
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Container(
//                    margin: EdgeInsets.only(
//                      top: 32,
//                      bottom: 32,
//                    ),
//                    child: Image(
//                      image: AssetImage('assests/images/logo.png'),
//                    ),
//                  ),
//                  Expanded(
//                    child: FutureBuilder(
//                      initialData: [],
//                      future: _dbHelper.getListofTasks(),
//                      builder: (context, snapshot) {
//                        return ScrollConfiguration(
//                          behavior: NoGlowBehavior(),
//                          child: ListView.builder(
//                              itemCount: snapshot.data.length,
//                              itemBuilder: (context, index) {
//                                return GestureDetector(
//                                  onTap: () {
//                                    Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => Taskpage(
//                                            task: snapshot.data[index],
//                                          )),
//                                    ).then((value) {
//                                      setState(() {});
//                                    });
//                                  },
//                                  child: TaskCard(
//                                    title: snapshot.data[index].title,
//                                    desc: snapshot.data[index].description,
//                                  ),
//                                );
//                              }),
//                        );
//                      },
//                    ),
//                  ),
//                ],
//              ),
//
//              Positioned(
//                //key: _fabKey,
//                bottom: 24.0,
//                right: 0.0,
//                child: GestureDetector(
//                  onTap: () {
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => Taskpage(
//                              task: null,
//                            ))).then((value) {
//                      setState(() {});
//                    });
//                  },
//                  child: Container(
//                    width: 50.0,
//                    height: 50.0,
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(20.0),
//                        gradient: LinearGradient(
//                          colors: [Color(0xff7349fe), Color(0xff643fdb)],
//                          begin: Alignment(0.0, -1.0),
//                          end: Alignment(0.0, 1.0),
//                        )),
//                    child: Image(
//                      image: AssetImage(
//                        "assests/images/add_icon.png",
//                      ),
//                    ),
//                  ),
//                ),
//              )
//            ]),
//          ),
//        ),
      floatingActionButton: FloatingActionButton(
        key: _fabKey,
      ),
    );
  }
  void showFAB() {
    CoachMark coachMarkFAB = CoachMark();
    RenderBox target = _fabKey.currentContext.findRenderObject();

    // you can change the shape of the mark
    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    markRect = Rect.fromCircle(center: markRect.center, radius: markRect.longestSide * 0.6);

    coachMarkFAB.show(
      targetContext: _fabKey.currentContext,
      markRect: markRect,
      children: [
        Center(
          child: Text(
            "This is called\nFloatingActionButton",
            style: const TextStyle(
              fontSize: 24.0,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        )
      ],
      duration: null, // we don't want to dismiss this mark automatically so we are passing null
      // when this mark is closed, after 1s we show mark on RaisedButton
      onClose: () => Timer(Duration(seconds: 1), () => showButton()),
    );
  }
  void showButton() {
    CoachMark coachMarkTile = CoachMark();
    RenderBox target = _buttonKey.currentContext.findRenderObject();

    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    markRect = markRect.inflate(5.0);

    coachMarkTile.show(
      targetContext: _fabKey.currentContext,
      markRect: markRect,
      markShape: BoxShape.rectangle,
      children: [
        Positioned(
          top: markRect.bottom + 15.0,
          right: 5.0,
          child: Text(
            "And this is a RaisedButton",
            style: const TextStyle(
              fontSize: 24.0,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        )
      ],
      duration: Duration(seconds: 5), // this effect will only last for 5s
    );
  }
}


