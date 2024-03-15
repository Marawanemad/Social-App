import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:socialapp/Modeles/PostModel.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/Cubit.dart';
import 'package:socialapp/Widgets/Component.dart';

// to make Card to put image and make a stack if we writer a text on the image
Widget Stack_Card(
    {required String ImageURL, required double height, String? StackText}) {
  return Card(
    // make card rounded from Edges
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    elevation: 5,
    // make stack to can write words on the image
    child: StackText != null
        ? Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            // make container to make image on all the screen width
            Container(
              width: double.infinity,
              // to put image in this container
              child: Image(
                image: NetworkImage(ImageURL),
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            // to make text with padding on the image with stack
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                StackText,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ])
        : Container(
            width: double.infinity,
            // to put image in this container
            child: Image(
              image: NetworkImage(ImageURL),
              height: height,
              fit: BoxFit.cover,
            ),
          ),
  );
}

// to make the buttons inside the posts
Widget PostButton(
    {required Widget iconShape,
    required Widget text,
    bool? EndAlignment,
    required onTap()}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: EndAlignment == null
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          iconShape,
          SizedBox(width: 5),
          text,
        ],
      ),
    ),
  );
}

// to make posts
Widget posts({required PostModel model, required context, required int index}) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image, name, date, more button
          Row(
            children: [
              // image
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage("${model.image}"),
              ),
              SizedBox(width: 10),
              // main information name, date, virification icon, more icon button
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and verification icon
                    Row(
                      children: [
                        Text(
                          "${model.name}",
                          style: TextStyle(
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.blue,
                          size: 15,
                        ),
                      ],
                    ),
                    // date text
                    Text(
                      "${model.dateTime}",
                      style: TextStyle(
                          height: 1.4, fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // to make button to post settings
              IconButton(
                onPressed: () {},
                icon: Icon(
                  IconBroken.More_Circle,
                  size: 25,
                ),
              )
            ],
          ),
          DividerLine(),
          // post text
          Text(
            "${model.text}",
            style: TextStyle(fontWeight: FontWeight.w400, height: 1.3),
          ),
          // make tags text
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 5),
            child: Wrap(
              children: [
                Container(
                  height: 15,
                  child: MaterialButton(
                    minWidth: 1,
                    padding: EdgeInsets.only(right: 5),
                    onPressed: () {},
                    child: Text(
                      "#Software",
                      style: TextStyle(color: Colors.blue, height: 1),
                    ),
                  ),
                ),
                Container(
                  height: 15,
                  child: MaterialButton(
                    minWidth: 1,
                    padding: EdgeInsets.only(right: 5),
                    onPressed: () {},
                    child: Text(
                      "#Software",
                      style: TextStyle(color: Colors.blue, height: 1),
                    ),
                  ),
                ),
                Container(
                  height: 15,
                  child: MaterialButton(
                    minWidth: 1,
                    padding: EdgeInsets.only(right: 5),
                    onPressed: () {},
                    child: Text(
                      "#Software",
                      style: TextStyle(color: Colors.blue, height: 1),
                    ),
                  ),
                ),
                Container(
                  height: 15,
                  child: MaterialButton(
                    minWidth: 1,
                    padding: EdgeInsets.only(right: 5),
                    onPressed: () {},
                    child: Text(
                      "#Software",
                      style: TextStyle(color: Colors.blue, height: 1),
                    ),
                  ),
                ),
                Container(
                  height: 15,
                  child: MaterialButton(
                    minWidth: 1,
                    padding: EdgeInsets.only(right: 5),
                    onPressed: () {},
                    child: Text(
                      "#Software",
                      style: TextStyle(color: Colors.blue, height: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // to make post image
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image: NetworkImage(
                        "${model.postImage}",
                      ),
                      fit: BoxFit.fill),
                ),
              ),
            ),
          // make the shape of comments and reacts numbers
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                // make button to show the reacts
                Expanded(
                  child: PostButton(
                    iconShape: Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                      size: 16,
                    ),
                    text: Text(
                      "${SocialCubit.get(context).LikesNumber[index]}",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    onTap: () {},
                  ),
                ),
                // make button to show the comments
                Expanded(
                  child: PostButton(
                    EndAlignment: true,
                    iconShape: Icon(
                      IconBroken.Chat,
                      color: Colors.cyan,
                      size: 16,
                    ),
                    text: Text(
                      "${SocialCubit.get(context).CommentNumber[index]} Comment",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    onTap: () {},
                  ),
                )
              ],
            ),
          ),
          DividerLine(height: 5),
          // to make shape of like, comment and share button
          Row(
            children: [
              // make comment button
              Expanded(
                child: InkWell(
                  onTap: () {
                    SocialCubit.get(context).CommentThePost(
                        SocialCubit.get(context).PostsId[index]);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            "${SocialCubit.get(context).userModel!.Image}"),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Write a comment ...",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
              // make like button
              PostButton(
                iconShape: Icon(
                  IconBroken.Heart,
                  color: Colors.red,
                  size: 16,
                ),
                text: Text(
                  "Like",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {
                  SocialCubit.get(context)
                      .likePost(SocialCubit.get(context).PostsId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
