import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/modules/setting.dart';

import '../styles/colors.dart';

Widget defultTextFormFeild({
  required String? Function(String?) validate,
  required TextEditingController control,
  required TextInputType type,
  bool obscure =false,
  required String lable,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? show,
  VoidCallback? tap,
  VoidCallback? submit(String)?,
  VoidCallback? change(String)?,
})=>TextFormField(
  style: TextStyle(color: Colors.black),
  validator: validate,
  controller: control,
  keyboardType: type,
  obscureText: obscure,
  onTap: tap,
  onChanged: change,
  onFieldSubmitted: submit,
  decoration: InputDecoration(
    labelText: lable,
    prefixIcon: Icon(prefix),
    suffixIcon: (suffix==null)?null:IconButton(
      onPressed: show,
      icon: Icon(suffix),
    ),
    border: const OutlineInputBorder(),
  ),
);

Future navigation(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
        builder:(context)=> widget));

Future navigationAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder:(context)=> widget,
    ),
        (route){
      return false;
    }
);

Widget defultButton({
  required VoidCallback function,
  required String text,
  bool uperCase=false,
})=>Container(
  height: 40.0,
  width: double.infinity,
  child: MaterialButton(
    textColor: Colors.white,
    color: defultColor,
    onPressed:function,
    child: (uperCase)?Text(text.toUpperCase()):Text(text),
  ),
);

Widget defultTextButton({
  required VoidCallback function,
  required String text,
})=>TextButton(
  onPressed: function,
  child: Text(
      text.toUpperCase()
  ),
);

///Colors of Toast
//error->red
//succes->green
//worning->amber
void toast({
  required String message,
  Color? color=Colors.amber,
})=>Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0
);

Widget myDivider()=> Padding(
  padding: const EdgeInsets.symmetric(horizontal: 25.0),
  child: Container(
    width: double.infinity,
    height: 1.5,
    color: Colors.grey,
  ),
);


PreferredSizeWidget appBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
})=>AppBar(
  title: Text(title!),
  titleSpacing: 5.0,
  actions: actions,
  leading: IconButton(
      icon:Icon(
          IconlyBroken.arrowLeft2
      ),
    onPressed: (){
        Navigator.pop(context);
    },
  ),


    );