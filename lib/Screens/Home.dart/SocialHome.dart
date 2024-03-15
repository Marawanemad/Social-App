import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Screens/AppScreens/Settings/SettingsScreen.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/Cubit.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/States.dart';
import 'package:icon_broken/icon_broken.dart';

import 'package:socialapp/Widgets/Component.dart';
import 'package:socialapp/Widgets/Navigation.dart';

// ignore: must_be_immutable
class SocialHome extends StatelessWidget {
  SocialHome({super.key});

  List<String> appBarTitle = [
    "New Feeds",
    "Chats",
    "Add Posts",
    "Users",
    "Settings",
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()
        ..getUsers()
        ..getPosts()
        ..getAllUsers(),
      child: BlocConsumer<SocialCubit, SocialState>(
        listener: (BuildContext context, SocialState state) {},
        builder: (BuildContext context, SocialState state) {
          var cubit = SocialCubit.get(context);
          cubit.uid = FirebaseAuth.instance.currentUser!.uid;
          return Scaffold(
            appBar: defaultAppBar(
              iconBack: false,
              title: appBarTitle[cubit.currentIndex],
              action: [
                // Settings button
                IconButton(
                    onPressed: () {
                      navigate(context: context, pageScreen: SettingsScreen());
                    },
                    icon: Icon(IconBroken.Setting)),
                // button to logout
                IconButton(
                  onPressed: () {
                    // use to make logOut
                    FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(IconBroken.Logout),
                )
              ],
            ),

            body: ConditionalBuilder(
              condition: state is! SocialLoadingState,
              builder: (context) =>
                  !FirebaseAuth.instance.currentUser!.emailVerified
                      ? Stack(children: [
                          // to make alert message when user not verify the acount
                          Container(
                            color: Colors.amber.withOpacity(0.6),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline),
                                SizedBox(width: 15),
                                Text(
                                  "Please verify your email",
                                  style: TextStyle(fontSize: 19),
                                ),
                                Spacer(),
                                TextButton(
                                    onPressed: cubit.VerifiedButton,
                                    child: Text("Send",
                                        style: TextStyle(
                                            fontSize: 19, color: Colors.cyan)))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 45.0),
                            child: cubit.Screens[cubit.currentIndex],
                          )
                        ])
                      : cubit.Screens[cubit.currentIndex],
              fallback: (context) => const Center(
                  child: CircularProgressIndicator(color: Colors.cyan)),
            ),

            // to make navigation bar can change screens with it
            bottomNavigationBar: BottomNavigationBar(
              // to change icon color
              unselectedIconTheme: IconThemeData(color: Colors.black),
              // to change font style
              unselectedLabelStyle: TextStyle(height: 1, fontSize: 10),
              // to make icons static not move when choose it
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              currentIndex: cubit.currentIndex,
              // to change index in cubit to make screen stateful
              onTap: (index) {
                cubit.changeBottomNav(index, context);
              },
              // to make icons in bar with names
              items: [
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload), label: 'Add Post'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chats'),
              ],
              selectedItemColor: Colors.cyan,
            ),
          );
        },
      ),
    );
  }
}
