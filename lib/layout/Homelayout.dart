import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Todo",style: TextStyle(fontSize: 44.0,color: Colors.blue),),),

      body: Stack(children: [


        pages[currentIndex]],),



      floatingActionButton: FloatingActionButton(onPressed: () {  },child: Icon(Icons.add,size:45.0,),),
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


  void createDatabase()async{

    var database= await openDatabase(
      'tasks.dp',
     version: 1,
     onCreate: (database,version){

        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY ,title TEXT, date TEXT , time TEXT , status TEXT)').
        then((value) {
          print("Database Created");
        }).catchError((error){
          print("There is error in database : ${error.toString()}");
        });

     },

      onOpen: (database){
        print("Database is opend");
      }

    );


  }



}
