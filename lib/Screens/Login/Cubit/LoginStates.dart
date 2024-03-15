abstract class SocialLoginState {}

class SocialLoginIntialState extends SocialLoginState {}

class SocialLoginLoadingState extends SocialLoginState {}

class SocialLoginErrorState extends SocialLoginState {
  final String error;
  SocialLoginErrorState(this.error);
}

class ChangeSuffixIconState extends SocialLoginState {}
