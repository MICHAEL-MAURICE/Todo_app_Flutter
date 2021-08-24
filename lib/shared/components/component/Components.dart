import 'package:flutter/material.dart';



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



Widget CardItem(Map m)=>Card(
elevation: 0.0,
  color: Colors.transparent,
  child:   ListTile(

    contentPadding: EdgeInsets.all(10.0),

    leading:CircleAvatar(radius: 60,child: Center(child: Text("    ${m["time"]}  ")),),
    title: Text(m["title"],style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
    subtitle: Text(m["date"]),

  ),
);