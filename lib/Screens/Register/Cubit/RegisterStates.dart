abstract class SocialRegisterState {}

class SocialRegisterIntialState extends SocialRegisterState {}

class SocialRegisterLoadingState extends SocialRegisterState {}

class SocialRegisterSuccessState extends SocialRegisterState {}

class SocialRegisterErrorState extends SocialRegisterState {
  final String error;
  SocialRegisterErrorState(this.error);
}

class SocialCreateSuccessState extends SocialRegisterState {}

class SocialCreateErrorState extends SocialRegisterState {
  final String error;
  SocialCreateErrorState(this.error);
}

class ChangeRegisterSuffixIconState extends SocialRegisterState {}
