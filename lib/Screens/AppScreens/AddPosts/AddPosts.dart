// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/Cubit.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/States.dart';
import 'package:socialapp/Widgets/Component.dart';
import 'package:socialapp/Widgets/FormField.dart';

class AddPosts extends StatelessWidget {
  AddPosts({super.key});

  var textPostController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()..getUsers(),
      child: BlocConsumer<SocialCubit, SocialState>(
        listener: (BuildContext context, SocialState state) {},
        builder: (BuildContext context, SocialState state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: "Create Post",
              action: [
                TextButton(
                  onPressed: () {
                    var now = DateTime.now();
                    if (cubit.PostImage != null) {
                      cubit.uploadPostImage(
                          dateTime: now.toString(),
                          text: textPostController.text);
                    } else {
                      cubit.CreatePost(
                          dateTime: now.toString(),
                          text: textPostController.text);
                    }
                    if (state is SocialCreatePostSuccessState) {
                      cubit.PostImage = null;
                      textPostController.text = '';
                    }
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(color: Colors.cyan),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              // use to can scroll with expanded
              child: CustomScrollView(
                slivers: [
                  // use to make scroll only the custom scroll view
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        if (state is SocialCreatePostLoadingState)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: LinearProgressIndicator(),
                          ),
                        Row(
                          children: [
                            // image
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  '${SocialCubit.get(context).userModel?.Image}'),
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
                                        "${SocialCubit.get(context).userModel?.name}",
                                        style: TextStyle(
                                            height: 1.4,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: formField(
                            controller: textPostController,
                            hentText: "What is in your mind....",
                            keyboardtype: TextInputType.text,
                            NoShape: true,
                          ),
                        ),
                        if (cubit.PostImage != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                // make container to make image on all the screen width
                                Container(
                                  width: double.infinity,
                                  height: 400,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4)),
                                  // to put image in this container
                                  child: Image(
                                    image: FileImage(cubit.PostImage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // to make text with padding on the image with stack
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.RemovePostImage();
                                    },
                                    icon: CircleAvatar(
                                      child: Icon(Icons.close_rounded),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  cubit.getPostImage();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.photo,
                                      color: Colors.cyan,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Add photo",
                                      style: TextStyle(
                                          color: Colors.cyan, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "# tags",
                                  style: TextStyle(
                                      color: Colors.cyan, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
