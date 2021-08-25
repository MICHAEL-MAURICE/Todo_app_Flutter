import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/Cubit/Cubit.dart';
import 'package:todo_app/shared/Cubit/States.dart';
import 'package:todo_app/shared/components/component/Components.dart';
import 'package:todo_app/shared/components/constants/constants.dart';
class New_tasks extends StatefulWidget {
  @override
  _New_tasksState createState() => _New_tasksState();
}

class _New_tasksState extends State<New_tasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,AppState>(builder: (context,state){
      var tasks= Appcubit.get(context).newTasks;
      return  Stack(

        children: [
          background_img(img:'assets/imgs/1.png')
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
