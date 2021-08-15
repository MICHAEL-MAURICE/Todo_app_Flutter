import 'package:flutter/material.dart';
import 'package:todo_app/modules/Arcived_tasks/Arcived_tasks.dart';
import 'package:todo_app/modules/done_tasks/Done_tasks.dart';
import 'package:todo_app/modules/new_tasks/New_tasks.dart';
class Home_layout extends StatefulWidget {
  @override
  _Home_layoutState createState() => _Home_layoutState();
}

class _Home_layoutState extends State<Home_layout> {

  int currentIndex=0;
  var pages=[New_tasks(),Done_tasks(),Archived_tasks()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Todo",style: TextStyle(fontSize: 44.0,color: Colors.blue),),),

      body: Stack(children: [


        pages[currentIndex]],),



      floatingActionButton: FloatingActionButton(onPressed: () {  },child: Icon(Icons.add),),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        currentIndex: currentIndex,
        onTap:(index){setState(() {
          currentIndex=index;
        });},
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.task),label: 'Tasks'),
        BottomNavigationBarItem(icon: Icon(Icons.done_outline_sharp),label: 'Done'),
        BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),label: 'Archive')
      ],),
      
    );
  }
}
