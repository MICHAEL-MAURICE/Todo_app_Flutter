import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/Arcived_tasks/Arcived_tasks.dart';
import 'package:todo_app/modules/done_tasks/Done_tasks.dart';
import 'package:todo_app/modules/new_tasks/New_tasks.dart';
import 'package:todo_app/shared/Cubit/Cubit.dart';
import 'package:todo_app/shared/Cubit/States.dart';
import 'package:todo_app/shared/components/component/Components.dart';
import 'package:todo_app/shared/components/constants/constants.dart';

class Home_layout extends StatelessWidget
{

  


  bool isbottomsheetShown =false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  IconData iconButton  = Icons.edit;
  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var  dateController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>Appcubit()..createDatabase(),
      
      child: BlocConsumer<Appcubit,AppState>(
        listener: (context,state){},
        builder: (context,state){
          Appcubit cubit = Appcubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text("Todo",style: TextStyle(fontSize: 44.0,color: Colors.blue),),),

            body: Stack(children: [


              cubit.pages[cubit.currentIndex]],),



            // floatingActionButton: FloatingActionButton(onPressed: () {
            //
            //   if(isbottomsheetShown )
            //   {
            //     if(formKey.currentState!.validate())
            //     {
            //
            //       // inserttoDatabase(titleController.text ,
            //       //     dateController.text,
            //       //     timeController.text
            //
            //       ).then((value) {
            //
            //         Navigator.pop(context);
            //         isbottomsheetShown=false;
            //         // setState(() {
            //         //
            //         //
            //         //   iconButton = Icons.edit;
            //         // });
            //
            //       });
            //
            //       // getDataFromDatabase(database).then((value){
            //       //   // setState(() {
            //       //   //
            //       //   //   tasks=value;
            //       //   // });
            //       //
            //       // });
            //
            //     }
            //     else{
            //       return null;
            //     }
            //
            //   }
            //   else{
            //     scaffoldKey.currentState!.showBottomSheet((context)=>Container(
            //       padding: EdgeInsets.all(22.0),
            //       color: Colors.white,
            //       child: Form(
            //         key: formKey,
            //         child: Column(
            //           mainAxisSize:MainAxisSize.min ,
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             defultTextField(controller: titleController,
            //                 type: TextInputType.text,
            //                 validation: (String value){
            //                   if(value.isEmpty)
            //                   {return "This field is Required";}
            //                   else
            //                     return null;
            //                 },
            //                 onTap: ()=>print ("taped"),
            //                 prefix: Icons.title
            //                 ,title:'Task Title'
            //                 ,isClicked: true),
            //
            //             SizedBox(height: 20,),
            //             defultTextField(controller: timeController,
            //                 type: TextInputType.datetime,
            //                 validation: (String ?value){
            //                   if(value==null || value.trim().length==0)
            //                   {return "This field is Required";}
            //                   return null;
            //                 }, prefix: Icons.watch_later_outlined
            //                 ,title:'Task Time'
            //                 ,isClicked: true,
            //                 onTap: (){
            //                   showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value){
            //
            //                     timeController.text=value!.format(context).toString();
            //
            //
            //                   });
            //
            //                 }),
            //             SizedBox(height: 20,),
            //             defultTextField(controller: dateController,
            //                 type: TextInputType.datetime,
            //                 validation: (String ?value){
            //                   if(value==null || value.trim().length==0)
            //                   {return "This field is Required";}
            //                   return null;
            //                 }, prefix: Icons.calendar_today
            //                 ,title:'Date Time'
            //                 ,isClicked: true,
            //                 onTap: (){
            //                   showDatePicker(context: context, initialDate:DateTime.now() , firstDate: DateTime.now(),
            //                       lastDate: DateTime.parse("2100-12-12")).then((value){
            //
            //                     dateController.text= "${value?.day} /${value?.month} /${value?.year}";
            //
            //
            //                   });
            //
            //                 })
            //           ],
            //         ),
            //       ),
            //     ),
            //
            //
            //
            //         elevation:20.0
            //     ).closed.then((value)   {
            //
            //       isbottomsheetShown=false;
            //       // setState(() {
            //       //
            //       //
            //       //   iconButton = Icons.edit;
            //       // });
            //
            //     } );
            //
            //     //
            //     // setState(() {
            //     //   iconButton =Icons.add;
            //     // });
            //     isbottomsheetShown=true;
            //   }
            //
            // },child: Icon(iconButton,size:33.0,),),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0.0,
              currentIndex: cubit.currentIndex,
              onTap:(index){


                cubit.navPages(index);

                //   setState(() {
                //
                // });
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.task),label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.done_outline_sharp),label: 'Done'),
                BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),label: 'Archive')
              ],),

          );

        },
      ),
    );
  }




}



