import 'package:flutter/material.dart';

class SnackBarMessage{
  Map<String,Color> messagesColors ={
    'Error':Colors.red,
    'Success':Colors.green,
};
  void showSnackBar(String message,BuildContext context,String state){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: messagesColors[state],
    ));
  }
}