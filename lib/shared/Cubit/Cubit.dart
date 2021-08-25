



import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/Arcived_tasks/Arcived_tasks.dart';
import 'package:todo_app/modules/done_tasks/Done_tasks.dart';
import 'package:todo_app/modules/new_tasks/New_tasks.dart';
import 'package:todo_app/shared/Cubit/States.dart';

class Appcubit extends Cubit<AppState>{
  Appcubit() : super(Intialstate());

  static Appcubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  late Database database;
  IconData iconButton  = Icons.edit;
  bool isbottomsheetShown =false;
  String mess="Tou don't Have any Task";
  var pages=[New_tasks(),Done_tasks(),Archived_tasks()];

  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> ArcivedTasks=[];
void navPages(int idx){
  currentIndex=idx;
  pages[currentIndex];
  emit(AppNavbarstate());
}


  void createDatabase(){

     openDatabase(
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
          getDataFromDatabase(database);
          print("Database is opend");
        }

    ).then((value) {

      database=value;
      emit(Createdatabasestate());

     });


  }



  Future inserttoDatabase(@required String title,@required String date,@required String time)async{

    return await database.transaction((txn) async {

      txn.rawInsert('INSERT INTO tasks(title , date ,time ,status) VALUES("$title","$date","$time","new")')
          .then((value) {

        print("$value Inserted to database sucessfully");
emit(Insertdatabasestate());

        getDataFromDatabase(database);
        emit(Getdatabasestate());

      }).catchError((error){

        print("Error in insertion ${error.toString()}");
      });



    }

    );

  }

  void getDataFromDatabase(database){
  newTasks=[];
  doneTasks=[];
  ArcivedTasks=[];

    return  database.rawQuery("SELECT * FROM tasks").then((value){


value.forEach((element){

  if(element['status'] == 'new'){
    newTasks.add(element);
  }
  else if(element['status'] == 'done'){
    doneTasks.add(element);
  }
  else ArcivedTasks.add(element);
});
if(newTasks.length>0||doneTasks.length>0||ArcivedTasks.length>0)
{  mess="";}else{
  mess="Tou don't Have any Task";
}
emit(Appmessstate());

      emit(Getdatabasestate());

    });


  }


  void changeButtomsheetState({

  required bool isShow,
    required IconData icon
}){
isbottomsheetShown=isShow;
iconButton=icon;
emit(Appbottomsheetstate());

  }

  void updateDatabase(
      {required String Status,
        required int id}
      ){
    database.rawUpdate("UPDATE tasks SET status=? WHERE id=?",

        ['$Status',id]

    ).then((value) {
      getDataFromDatabase(database);
      emit(Updatedatabasestate());


    });



  }

  void deleteDatabase(
      {
        required int id}
      ){
    database.rawUpdate("DELETE FROM tasks WHERE id=?",

        [id]

    ).then((value) {
      getDataFromDatabase(database);
      emit( Deletdatabasestate());


    });



  }
}