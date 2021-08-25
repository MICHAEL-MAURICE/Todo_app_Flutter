import 'package:flutter/material.dart';
import 'package:todo_app/shared/Cubit/Cubit.dart';



Widget background_img({required String img}){
  return Center(child:  Image.asset(img,color: Colors.blue,));
}
//Defult TextFormField

Widget defultTextField({required TextEditingController  controller,
  required TextInputType type,
  Function? onChange,
  Function? onSubmit,
  Function ?onTap,
  bool isPassword=false,
  required Function validation,
   required  String  title,
  required IconData prefix,
  IconData ?suffix,
  Function? suffixPress,
  required  bool isClicked,
})=>TextFormField(
controller: controller,
keyboardType: type,
 onChanged: (s){onChange!(s);},
  onFieldSubmitted: (s){onSubmit!(s);},
  obscureText: isPassword,
  enabled: isClicked,
  onTap: (){
  onTap!();
  },
validator: (s){
  validation(s);
},

  decoration: InputDecoration(
    labelText: title,
    prefixIcon: Icon(prefix),
    suffix: suffix!=null?IconButton(onPressed: (){suffixPress!();}, icon: Icon(suffix)):null,
    border: OutlineInputBorder()

  ),


);



Widget CardItem(Map m,context)=>Card(
elevation: 0.0,
  color: Colors.transparent,
  child:   Dismissible(
    key: Key(m['id'].toString()),
    background: Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.red,

    child: Row(
      
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.restore_from_trash_sharp,color: Colors.black,),
      ],
    ),
    ),
    onDismissed: (dirction){

      Appcubit.get(context).deleteDatabase(id: m['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(

mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            CircleAvatar(radius: 35,child: Center(child: Text("${m["time"]}" )),),
Column(children: [
      Text(m["title"],style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
      Text(m["date"]),
],)
           , Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  Appcubit.get(context).updateDatabase(id:m['id'], Status: 'done');

                }, icon: Icon(Icons.check_box,color: Colors.green,))

                , IconButton(onPressed: (){Appcubit.get(context).updateDatabase(id:m['id'], Status: 'Arcived');}, icon: Icon(Icons.archive,color: Colors.black54,))
              ],
            ),

          ]





      ),
    ),
  ),
);