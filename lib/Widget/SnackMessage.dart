import 'package:flutter/material.dart';

void snackMessage(BuildContext context,String message, [bool sError=false]){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),backgroundColor: sError?Colors.redAccent:null,
      ));
}