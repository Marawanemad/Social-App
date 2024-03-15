// to make navigator with replacment can not return back
import 'package:flutter/material.dart';

void navigateAndFinish({required context, required pageScreen}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => pageScreen,
    ),
    (route) => false,
  );
}

// to make navigator without replacment can return back
void navigate({required context, required pageScreen}) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pageScreen,
      ));
}
