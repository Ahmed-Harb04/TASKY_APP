import 'package:flutter/material.dart';

abstract class AppDialog {
  static void showDialogLoading(BuildContext context){
    showDialog(context: context,
     builder: (context)=>AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 15,),
          Text(
            "Loading",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          )
        ],
      ),
     ));
  }
  static void showDialogError(BuildContext context, String error){
    showDialog(context: context
    , builder: (context)=>AlertDialog(
      title: Text(
        "Title Error",
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
      content: Text(
        error,
        style: TextStyle(
          fontSize: 15,
          color: Colors.red
        ),
      ),
    ));
  }
}