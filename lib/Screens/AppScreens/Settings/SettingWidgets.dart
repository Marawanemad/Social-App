import 'package:flutter/material.dart';

// to make cover image in setting screen
Widget CoverImage({required Image}) {
  return Container(
    width: double.infinity,
    height: 150,
    // to put image in this container
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4),
        topRight: Radius.circular(4),
      ),
      image: DecorationImage(
        image: Image,
        fit: BoxFit.cover,
      ),
    ),
  );
}

// to make user image in setting screen
Widget UserImage({required Image}) {
  // to make circle around the image
  return CircleAvatar(
    radius: 64,
    backgroundColor: Colors.grey[100],
    // to make circle and put image inside it
    child: CircleAvatar(
      radius: 60,
      backgroundImage: Image,
    ),
  );
}
