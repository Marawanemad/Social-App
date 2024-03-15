import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:socialapp/Screens/AppScreens/Settings/SettingWidgets.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/Cubit.dart';
import 'package:socialapp/Screens/Home.dart/Cubit/States.dart';
import 'package:socialapp/Widgets/Component.dart';
import 'package:socialapp/Widgets/FormField.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  bool controllerChanged = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()..getUsers(),
      child: BlocConsumer<SocialCubit, SocialState>(
        listener: (BuildContext context, SocialState state) {},
        builder: (BuildContext context, SocialState state) {
          var userModel = SocialCubit.get(context).userModel;
          var cubit = SocialCubit.get(context);
          var ProfileImagePicker = cubit.ProfileImage;
          var CoverImagePicker = cubit.CoverImage;
          if (!controllerChanged) {
            nameController.text = userModel?.name ?? '';
            bioController.text = userModel?.bio ?? '';
            phoneController.text = userModel?.phone ?? '';
          }
          return Scaffold(
            appBar: defaultAppBar(context: context, title: "Edit Profile"),
            body: ConditionalBuilder(
              condition: userModel != null,
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // make linear progress indicator when loading

                      if (state is SocialUpdateUserLoadingState)
                        Padding(
                            padding: EdgeInsetsDirectional.all(8),
                            child: LinearProgressIndicator()),
                      Container(
                        height: 190,
                        // to make more than widget on each others
                        child: Stack(
                          // to put the another widget in the bottom
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  CoverImage(
                                    Image: CoverImagePicker == null
                                        ? NetworkImage("${userModel?.Cover}")
                                        // to get the image from the picker stored in file
                                        : FileImage(CoverImagePicker),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        cubit.getCoverImage();
                                        // to make new edit donot change until upload it or ignore
                                        controllerChanged = true;
                                      },
                                      icon: CircleAvatar(
                                          child: Icon(IconBroken.Camera)))
                                ],
                              ),
                            ),
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                UserImage(
                                  Image: ProfileImagePicker == null
                                      ? NetworkImage(
                                          "${userModel?.Image}",
                                        )
                                      // to get image from picker stored in file
                                      : FileImage(ProfileImagePicker),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.getProfileImage();
                                    // to make new edit donot change until upload it or ignore
                                    controllerChanged = true;
                                  },
                                  icon: CircleAvatar(
                                    child: Icon(IconBroken.Camera),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // form field for name

                      formField(
                        boxShape: true,
                        controller: nameController,
                        labelText: "Name",
                        NoShape: true,
                        prefixicon: Icon(IconBroken.User),
                        keyboardtype: TextInputType.name,
                        text_input_action: TextInputAction.next,
                        validiationMesseage: "Name must not be empty",
                      ),
                      SizedBox(height: 5),

                      // form field for bio
                      formField(
                          boxShape: true,
                          controller: bioController,
                          labelText: "Bio",
                          NoShape: true,
                          prefixicon: Icon(IconBroken.Info_Circle),
                          keyboardtype: TextInputType.text,
                          text_input_action: TextInputAction.next,
                          validiationMesseage: "Bio must not be empty"),
                      SizedBox(height: 5),

                      // form field for phone
                      formField(
                          boxShape: true,
                          controller: phoneController,
                          labelText: "phone",
                          NoShape: true,
                          prefixicon: Icon(IconBroken.Call),
                          keyboardtype: TextInputType.phone,
                          validiationMesseage: "Phone must not be empty"),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Column(children: [
                                  Text(
                                    "100",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Posts",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ]),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Column(children: [
                                  Text(
                                    "161",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Photos",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ]),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Column(children: [
                                  Text(
                                    "250",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Followers",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ]),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Column(children: [
                                  Text(
                                    "300",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Followings",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ]),
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                  onPressed: () {
                                    cubit.updateUser(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                    if (cubit.ProfileImage != null)
                                      cubit.uploadProfileImage();
                                    if (cubit.CoverImage != null)
                                      cubit.uploadCoverImage();
                                  },
                                  child: Text("Update Data")),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (BuildContext context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
