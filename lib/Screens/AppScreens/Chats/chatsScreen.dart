import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Screens/AppScreens/Chats/ChatWidgets.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/Cubit.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/States.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (BuildContext context, SocialState state) {},
      builder: (BuildContext context, SocialState state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).AllUsers.length > 0,
            builder: (context) => ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                    context: context,
                    userModel: SocialCubit.get(context).AllUsers[index]),
                itemCount: SocialCubit.get(context).AllUsers.length),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
