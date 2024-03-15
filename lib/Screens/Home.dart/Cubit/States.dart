abstract class SocialState {}

class SocialIntialState extends SocialState {}

// get data
class SocialLoadingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;
  SocialGetUserErrorState(this.error);
}

// make Email verification
class SocialVerifiedSuccessState extends SocialState {}

class SocialVerifiedErrorState extends SocialState {
  final String error;
  SocialVerifiedErrorState(this.error);
}

// Navigation bar
class SocialChangeButtomNavState extends SocialState {}

class SocialAddPostNavState extends SocialState {}

// profile image picker
class SocialProfileImagePickedSuccessState extends SocialState {}

class SocialProfileImagePickedErrorState extends SocialState {}

// cover image picker
class SocialCoverImagePickedSuccessState extends SocialState {}

class SocialCoverImagePickedErrorState extends SocialState {}

// upload profile image
class SocialUploadProfileImageSuccessState extends SocialState {}

class SocialUploadProfileImageErrorState extends SocialState {}

// upload cover image
class SocialUploadCoverImageSuccessState extends SocialState {}

class SocialUploadCoverImageErrorState extends SocialState {}

// Update user data
class SocialUpdateUserLoadingState extends SocialState {}

class SocialUpdateUserErrorState extends SocialState {}

// create post
class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostSuccessState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {}

class SocialRemovePostImageState extends SocialState {}

// get Posts
class SocialGetPostsLoadingState extends SocialState {}

class SocialGetPostsSuccessState extends SocialState {}

class SocialGetPostsErrorState extends SocialState {}

// Make like on post
class SocialLikePostsSuccessState extends SocialState {}

class SocialLikePostsErrorState extends SocialState {}

// Make Comment on post
class SocialCommentPostsSuccessState extends SocialState {}

class SocialCommentPostsErrorState extends SocialState {}

// Get All users
class SocialGetAllUserSuccessState extends SocialState {}

class SocialGetAllUserErrorState extends SocialState {}

// Send message
class SocialSendMessageSuccessState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {}

// Get message
class SocialGetMessageSuccessState extends SocialState {}

// Chat images picker
class SocialChatImagesPickedSuccessState extends SocialState {}

class RemoveChatImagesPickedSuccessState extends SocialState {}

class SocialChatImagesPickedErrorState extends SocialState {}

// Upload Chat images
class SocialChatImagesUploadLoadingState extends SocialState {}

class SocialChatImagesUploadSuccessState extends SocialState {}

class SocialChatImagesUploadErrorState extends SocialState {}
