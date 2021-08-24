



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
  var pages=[New_tasks(),Done_tasks(),Archived_tasks()];

  List<Map> tasks=[];
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
          getDataFromDatabase(database).then((value){
            tasks=value;
           emit(Getdatabasestate());

          });
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

      }).catchError((error){

        print("Error in insertion ${error.toString()}");
      });



    }

    );

  }

  Future <List<Map>> getDataFromDatabase(database)async{

    return await database.rawQuery("SELECT * FROM tasks");

  }



}