
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/Cubit/Cubit.dart';
import 'package:todo_app/shared/Cubit/States.dart';
import 'package:todo_app/shared/components/component/Components.dart';
import 'package:todo_app/shared/components/constants/constants.dart';
class Archived_tasks extends StatefulWidget {
  @override
  _Archived_tasksState createState() => _Archived_tasksState();
}

class _Archived_tasksState extends State<Archived_tasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,AppState>(builder: (context,state){
      var tasks= Appcubit.get(context).ArcivedTasks;
      return  Stack(

        children: [
          Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              SizedBox(height: 100,),
              background_img(img:'assets/imgs/3.png'),
              Text(Appcubit.get(context).mess,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.blue),)
            ],
          )
          ,ListView.separated(itemBuilder: (context,index)=>CardItem(tasks[index],context), separatorBuilder: (context,index){

            return Container(
              height: 2.0,
              width: double.infinity,
              color: Colors.grey[300],
            );

          }, itemCount: tasks.length)
        ],



      );
    }, listener: (context,state){});




  }
}
