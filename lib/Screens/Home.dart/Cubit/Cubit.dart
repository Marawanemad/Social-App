import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/Modeles/MessageModel.dart';
import 'package:socialapp/Modeles/PostModel.dart';
import 'package:socialapp/Modeles/SocialUserModel.dart';
import 'package:socialapp/Screens/AppScreens/AddPosts/AddPosts.dart';
import 'package:socialapp/Screens/AppScreens/Chats/chatsScreen.dart';
import 'package:socialapp/Screens/AppScreens/Feeds/FeedsScreen.dart';

import 'package:socialapp/Screens/Home.dart/Cubit/States.dart';
import 'package:socialapp/Widgets/Navigation.dart';
import 'package:socialapp/Widgets/ShowToast.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCubit extends Cubit<SocialState> {
// to make intialize super cubit
  SocialCubit() : super(SocialIntialState());
// to make object from cubit use it in any place
  static SocialCubit get(context) => BlocProvider.of(context);

  // to get user id and use it
  var uid = FirebaseAuth.instance.currentUser!.uid;
  SocilUserModel? userModel;
  void getUsers() {
    emit(SocialLoadingState());
    print("the uid " + uid.toString());
    FirebaseFirestore.instance.collection("Users").doc(uid).get().then((value) {
      print(value.data());
      // to get data from map
      userModel = SocilUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetUserErrorState(onError));
    });
  }

  // Email verification
  void VerifiedButton() {
    emit(SocialLoadingState());
    FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
      ShowToast(
          msg: "Check your mail",
          colorstate: toastState.SUCCESS,
          toasttimelength: toastLengthTime.SHORT,
          position: 'top');
      emit(SocialVerifiedSuccessState());
    }).catchError((error) {
      ShowToast(
          msg: error.toString(),
          colorstate: toastState.ERROR,
          toasttimelength: toastLengthTime.LONG,
          position: 'top');
      emit(SocialVerifiedErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> Screens = [
    FeedsScreen(),
    AddPosts(),
    ChatsScreen(),
  ];
  // Function to change Navigation Screens
  void changeBottomNav(int index, context) {
    if (index == 0) getPosts();
    if (index == 2) getAllUsers();
    if (index == 1) {
      navigate(context: context, pageScreen: AddPosts());
      emit(SocialAddPostNavState());
    } else {
      currentIndex = index;
      emit(SocialChangeButtomNavState());
    }
  }

  // to get image in the file
  File? ProfileImage;
  // to get image from device
  var picker = ImagePicker();
  // make function to get image
  Future<void> getProfileImage() async {
    // make user upload image from gallary
    final pickedFile = await picker.pickMedia();
    if (pickedFile != null) {
      // store path of the image in the file
      ProfileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print("Error happened when upload image");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  // to get image in the file
  File? CoverImage;
  // to get image from device
  // make function to get image
  Future<void> getCoverImage() async {
    // make user upload image from gallary
    final pickedFile = await picker.pickMedia();
    if (pickedFile != null) {
      // store path of the image in the file
      CoverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print("Error happened when upload image");
      emit(SocialCoverImagePickedErrorState());
    }
  }

  // to upload profile image
  String? profileImageUrl;
  void uploadProfileImage() {
    // to upload the file to firebase store
    FirebaseStorage.instance
        // to make access on the path
        .ref()
        // to show what is the file name
        .child("Users/${Uri.file(ProfileImage!.path).pathSegments.last}")
        // to start upload this file
        .putFile(ProfileImage!)
        .then((value) {
      // to get the file we upload
      value.ref.getDownloadURL().then((value) {
        // saved url in variable to use it later
        profileImageUrl = value;
        // make update to firebase data when upload image
        updateUser();
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // to upload cover image
  String? CoverImageUrl;
  void uploadCoverImage() {
    // to upload the file to firebase store
    FirebaseStorage.instance
        // to make access on the path
        .ref()
        // to show what is the file name
        .child("Users/${Uri.file(CoverImage!.path).pathSegments.last}")
        // to start upload this file
        .putFile(CoverImage!)
        .then((value) {
      // to get the file we upload
      value.ref.getDownloadURL().then((value) {
        // saved url in variable to use it later
        CoverImageUrl = value;
        // make update to firebase data when upload image
        updateUser();
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // to update user data
  void updateUser({String? name, String? phone, String? bio}) {
    emit(SocialUpdateUserLoadingState());
    SocilUserModel model = SocilUserModel(
      // check if no data send save the old data donot change it
      name: name ?? userModel!.name,
      phone: phone ?? userModel!.phone,
      bio: bio ?? userModel!.bio,
      Image: profileImageUrl ?? userModel!.Image,
      Cover: CoverImageUrl ?? userModel!.Cover,
      uID: userModel!.uID,
      email: userModel!.email,
    );
    // upload new data as a map to save it in firebase
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .update(model.toMap())
        .then((value) {
      print("Data is updated");
      getUsers();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateUserErrorState());
    });
  }

  // to create posts
  void CreatePost(
      {required String dateTime, required String text, String? PostImage}) {
    PostModel model = PostModel(
      name: userModel!.name,
      uID: userModel!.uID,
      image: userModel!.Image,
      dateTime: dateTime,
      text: text,
      postImage: PostImage ?? '',
    );
    // upload new data as a map to save it in firebase
    FirebaseFirestore.instance
        .collection("Posts")
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  // to get image in the file
  File? PostImage;
  // to get image from device
  // make function to get image
  Future<void> getPostImage() async {
    // make user upload image from gallary
    final pickedFile = await picker.pickMedia();
    if (pickedFile != null) {
      // store path of the image in the file
      PostImage = File(pickedFile.path);
      emit(SocialCreatePostSuccessState());
    } else {
      print("Error happened when upload image");
      emit(SocialCreatePostErrorState());
    }
  }

  void RemovePostImage() {
    PostImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    // to upload the file to firebase store
    FirebaseStorage.instance
        // to make access on the path
        .ref()
        // to show what is the file name
        .child("Posts/${Uri.file(PostImage!.path).pathSegments.last}")
        // to start upload this file
        .putFile(PostImage!)
        .then((value) {
      // to get the file we uploaded and create a post
      value.ref.getDownloadURL().then((value) {
        CreatePost(dateTime: dateTime, text: text, PostImage: value);
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  // to get posts from firebase and store it in list
  List<PostModel> postList = [];
  List<String> PostsId = [];
  List<int> LikesNumber = [];
  List<int> CommentNumber = [];
  void getPosts() {
    emit(SocialGetPostsLoadingState());
    postList = [];
    FirebaseFirestore.instance.collection("Posts").get().then((value) {
      // to get data from firebase and store it in list
      value.docs.forEach((element) {
        element.reference.collection("Comment").get().then((value) {
          CommentNumber.add(value.docs.length);
          // to add id for each post
          PostsId.add(element.id);
          // to add in the list map from each post
          postList.add(PostModel.fromJson(element.data()));
        });
        element.reference.collection("Likes").get().then((value) {
          LikesNumber.add(value.docs.length);
          emit(SocialGetPostsSuccessState());
        });
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetPostsErrorState());
    });
  }

  // to make like on any post
  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection("Likes")
        .doc(userModel!.uID)
        .set({'like': true}).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialLikePostsErrorState());
    });
  }

  // to make comment on any post
  void CommentThePost(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection("Comment")
        .doc(userModel!.uID)
        .set({'comment': true}).then((value) {
      emit(SocialCommentPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCommentPostsErrorState());
    });
  }

  // to get all users use the app
  List<SocilUserModel> AllUsers = [];
  void getAllUsers() {
    if (AllUsers.length == 0)
      FirebaseFirestore.instance.collection("Users").get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uID'] != uid)
            AllUsers.add(SocilUserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUserSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(SocialGetAllUserErrorState());
      });
  }

  // to send message
  sendMessage({
    required String ReceiverID,
    required String messageText,
    required String date,
    required String Time,
    required String messageImage,
  }) {
    MessageModel messageModel = MessageModel(
      SenderID: uid,
      ReceiverID: ReceiverID,
      date: date,
      Time: Time,
      messageText: messageText,
      messageImage: messageImage,
    );
    // to save messages in sender email
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Chats")
        .doc(ReceiverID)
        .collection("Message")
        .add(messageModel.toMap())
        .then(
      (value) {
        emit(SocialSendMessageSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(SocialSendMessageErrorState());
      },
    );
    // to save message in receiver email
    FirebaseFirestore.instance
        .collection("Users")
        .doc(ReceiverID)
        .collection("Chats")
        .doc(uid)
        .collection("Message")
        .add(messageModel.toMap())
        .then(
      (value) {
        emit(SocialSendMessageSuccessState());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(SocialSendMessageErrorState());
      },
    );
  }

  List<MessageModel> messages = [];
  void getMessages({required String ReceiverID}) {
    // to get message from firebase but use snapshots to get it streming
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Chats')
        .doc(ReceiverID)
        .collection('Message')
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      // to remove dublicate data
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  // to get image in the file
  File? ChatImages;
  // make function to get image
  Future<void> getChatImages() async {
    // make user upload image from gallary
    final pickedFile = await picker.pickMedia();
    if (pickedFile != null) {
      // store path of the image in the file
      ChatImages = File(pickedFile.path);
      emit(SocialChatImagesPickedSuccessState());
    } else {
      print("Error happened when upload image");
      emit(SocialChatImagesPickedErrorState());
    }
  }

  // to upload Chat images
  String ChatImagesUrl = '';
  void uploadChatImages() {
    emit(SocialChatImagesUploadLoadingState());
    // to upload the file to firebase store
    FirebaseStorage.instance
        // to make access on the path
        .ref()
        // to show what is the file name
        .child("Users/${Uri.file(ChatImages!.path).pathSegments.last}")
        // to start upload this file
        .putFile(ChatImages!)
        .then((value) {
      // to get the file we upload
      value.ref.getDownloadURL().then((value) {
        // saved url in variable to use it later
        ChatImagesUrl = value;
        // make update to firebase data when upload image
        emit(SocialChatImagesUploadSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialChatImagesUploadErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialChatImagesUploadErrorState());
    });
  }

  void removeImagePicked() {
    ChatImages = null;
    ChatImagesUrl = '';
    emit(RemoveChatImagesPickedSuccessState());
  }
}
