import 'package:flutter/material.dart';
import 'package:socialapp/Modeles/MessageModel.dart';
import 'package:socialapp/Modeles/SocialUserModel.dart';
import 'package:socialapp/Screens/AppScreens/Chats/theChat.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/Cubit.dart';
import 'package:socialapp/Widgets/Component.dart';
import 'package:socialapp/Widgets/Navigation.dart';

Widget buildChatItem({required SocilUserModel userModel, required context}) {
  return Column(
    children: [
      DividerLine(),
      InkWell(
        onTap: () {
          navigate(context: context, pageScreen: theChat(userModel: userModel));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${userModel.Image}"),
              ),
              SizedBox(width: 10),
              Text(
                "${userModel.name}",
                style: TextStyle(
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget MessageFrame({
  required String messageText,
  required String date,
  required color,
  required bool sender,
  required context,
  required MessageModel messageModel,
}) {
  return Stack(
    alignment: sender
        ? AlignmentDirectional.bottomEnd
        : AlignmentDirectional.bottomStart,
    children: [
      Align(
        alignment: sender
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: Container(
          width: messageText.length >= MediaQuery.of(context).size.width
              ? MediaQuery.of(context).size.width * 0.8
              : null,
          padding: EdgeInsets.only(
              bottom: 15,
              right: sender ? 45 : 15,
              left: sender ? 15 : 45,
              top: 15),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: sender ? Radius.circular(20) : Radius.circular(0),
              bottomEnd: sender ? Radius.circular(0) : Radius.circular(20),
              topStart: Radius.circular(20),
              topEnd: Radius.circular(20),
            ),
          ),
          child: messageModel.messageImage != ''
              ? Column(
                  children: [
                    theChatImageShape(
                        context: context,
                        imageurl: messageModel.messageImage.toString()),
                    Text(
                      messageText,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              : Text(
                  messageText,
                  style: TextStyle(fontSize: 16),
                ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 5.0, left: 5.0),
        child: Text(
          date,
          style: TextStyle(fontSize: 11),
          textDirection: sender ? TextDirection.ltr : TextDirection.rtl,
        ),
      )
    ],
  );
}

Widget theMessageShape(
    {required messageController,
    required context,
    required userModel,
    required int index}) {
  var message = SocialCubit.get(context).messages[index];
  var condition = SocialCubit.get(context).uid == message.SenderID;
  // make sender and receiver message
  return MessageFrame(
      messageText: "${message.messageText}",
      color: condition ? Colors.cyan[100] : Colors.blueGrey[200],
      sender: condition ? true : false,
      date: '${message.Time}',
      context: context,
      messageModel: message);
}

Widget theChatImageShape({required context, required String imageurl}) {
  // make sender message
  return Container(
    width: 200,
    height: 200,
    // to put image in this container
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4),
        topRight: Radius.circular(4),
      ),
      image: DecorationImage(
        image: NetworkImage(imageurl),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget showImagePicked({required cubit, required state}) {
  return Stack(
    alignment: AlignmentDirectional.topEnd,
    children: [
      Container(
        width: double.infinity,
        height: 250,
        // to put image in this container
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          image: DecorationImage(
            image: FileImage(cubit.ChatImages!),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundColor: Colors.cyan,
              child: IconButton(
                  onPressed: () {
                    if (cubit.ChatImages != null) {
                      cubit.uploadChatImages();
                    }
                  },
                  icon: Icon(
                    Icons.done_rounded,
                    color: Colors.black,
                  )),
            ),
            SizedBox(width: 5),
            CircleAvatar(
              backgroundColor: Colors.red,
              child: IconButton(
                  onPressed: () => cubit.removeImagePicked(),
                  icon: Icon(
                    Icons.cancel_rounded,
                    color: Colors.black,
                  )),
            )
          ],
        ),
      ),
    ],
  );
}
