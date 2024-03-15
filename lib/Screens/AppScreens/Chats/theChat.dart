import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:socialapp/Modeles/SocialUserModel.dart';
import 'package:socialapp/Screens/AppScreens/Chats/ChatWidgets.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/Cubit.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/States.dart';
import 'package:socialapp/Widgets/FormField.dart';
import 'package:socialapp/Widgets/ShowToast.dart';

// ignore: must_be_immutable
class theChat extends StatelessWidget {
  SocilUserModel userModel;
  theChat({super.key, required this.userModel});
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context)
            .getMessages(ReceiverID: userModel.uID.toString());
        return BlocConsumer<SocialCubit, SocialState>(
          listener: (BuildContext context, SocialState state) {},
          builder: (BuildContext context, SocialState state) {
            var cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
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
                backgroundColor: Colors.grey[50],
                foregroundColor: Colors.black,
              ),
              body: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: cubit.messages.length > 0,
                      builder: (BuildContext context) {
                        return Expanded(
                          child: ListView.separated(
                            reverse: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => theMessageShape(
                                context: context,
                                index: index,
                                messageController: messageController,
                                userModel: userModel),
                            itemCount: cubit.messages.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                          ),
                        );
                      },
                      fallback: (BuildContext context) => Spacer(),
                    ),
                    SizedBox(height: 5),
                    // to show image picked if you choose one
                    if (cubit.ChatImages != null)
                      showImagePicked(cubit: cubit, state: state),
                    Row(
                      children: [
                        Expanded(
                          // to make textfield in static size
                          child: ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 150),
                              child: formField(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                controller: messageController,
                                keyboardtype: TextInputType.multiline,
                                text_input_action: TextInputAction.newline,
                                hentText: "Type your message",
                                boxShape: true,
                                circularBorder: 30,
                                suffixicon: IconBroken.Camera,
                                // BorderColor: Colors.black,
                                suffixpressed: () {
                                  cubit.getChatImages();
                                },
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: (state is SocialChatImagesUploadLoadingState ||
                                  cubit.ChatImagesUrl == '' &&
                                      cubit.ChatImages != null)
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.cyan),
                                )
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.cyan,
                                  child: IconButton(
                                      onPressed: () {
                                        if (cubit.ChatImagesUrl == '' &&
                                            messageController.text == '') {
                                          ShowToast(
                                              msg: 'No message to send ',
                                              colorstate: toastState.ERROR,
                                              toasttimelength:
                                                  toastLengthTime.LONG,
                                              position: 'center');
                                        }
                                        if (messageController.text == '' &&
                                                cubit.ChatImagesUrl != '' ||
                                            messageController.text != '' &&
                                                cubit.ChatImagesUrl != '')
                                          cubit.sendMessage(
                                            ReceiverID:
                                                userModel.uID.toString(),
                                            messageText: messageController.text,
                                            date: DateTime.now().toString(),
                                            Time: TimeOfDay.now()
                                                .format(context)
                                                .toString(),
                                            messageImage: cubit.ChatImagesUrl,
                                          );

                                        if (messageController.text != '' &&
                                            cubit.ChatImagesUrl == '')
                                          cubit.sendMessage(
                                            ReceiverID:
                                                userModel.uID.toString(),
                                            messageText: messageController.text,
                                            date: DateTime.now().toString(),
                                            Time: TimeOfDay.now()
                                                .format(context)
                                                .toString(),
                                            messageImage: '',
                                          );

                                        cubit.ChatImagesUrl = '';
                                        messageController.text = '';
                                        cubit.ChatImages = null;
                                      },
                                      icon: Icon(
                                        IconBroken.Send,
                                        color: Colors.black,
                                      )),
                                ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
