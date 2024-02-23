import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static const product ="product";
  static const category ="category";
  static const banner ="banner";
  static const productlist ="productlist";
}

void showMessage(BuildContext context,{required String text,required Color color}){
  ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
          backgroundColor: color,
          content: Text(text))
  );
}