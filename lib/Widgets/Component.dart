import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';

PreferredSizeWidget defaultAppBar(
    {bool iconBack = true,
    context,
    Widget? leading,
    String? title,
    List<Widget>? action}) {
  return AppBar(
    backgroundColor: Colors.grey[50],
    foregroundColor: Colors.black,
    elevation: 0,
    leadingWidth: 30,
    leading: iconBack
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              IconBroken.Arrow___Left_2,
              size: 30,
            ))
        : leading,
    title: Text(title ?? "",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
    actions: action,
  );
}

// to make line between widgets
Widget DividerLine({double? height}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: height == null ? 10.0 : height),
    child: Container(
      height: 1,
      color: Colors.grey[300],
    ),
  );
}
