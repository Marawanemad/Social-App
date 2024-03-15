import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// to show alert messeage
void ShowToast({
  required String msg,
  required toastState colorstate,
  required toastLengthTime toasttimelength,
  required String position,
}) {
  Fluttertoast.showToast(
      msg: msg,
      // to show the time of messeage in android long =5sec , short=1sec
      toastLength: chooseToastLength(toasttimelength),
      // to show the time of messeage in web and IOS
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(colorstate),
      fontSize: 15,
      textColor: Colors.white,
      // to show the position where it appear in
      gravity: Gravity(position));
}

// enum to choose from multiple state
enum toastState { SUCCESS, ERROR, WARNING }

enum toastLengthTime { LONG, SHORT }

// to choose Time depending on toastLengthTime
chooseToastLength(toastLengthTime state) {
  switch (state) {
    case toastLengthTime.LONG:
      return Toast.LENGTH_LONG;
    case toastLengthTime.SHORT:
      return Toast.LENGTH_SHORT;
  }
}

// to choose color depending on colorstate
Color chooseToastColor(toastState colorstate) {
  switch (colorstate) {
    case toastState.SUCCESS:
      return Colors.green;
    case toastState.ERROR:
      return Colors.red;
    case toastState.WARNING:
      return Colors.amber;
  }
}

// to choose position of toast
Gravity(String position) {
  switch (position) {
    case 'center':
      return ToastGravity.CENTER;
    case 'bottom':
      return ToastGravity.BOTTOM;
    case 'top':
      return ToastGravity.TOP;
  }
}
