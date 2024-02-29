abstract class JobFinderState {}

class JobFinderInitialState extends JobFinderState {}

class ChangeBottomNavBarIndexState extends JobFinderState {}

class ChangeActiveOrRejectedTabBarIndexState extends JobFinderState {}

class ChangeJobDetailTabBarIndexStateState extends JobFinderState {}

class ChangePasswordVisibilityState extends JobFinderState {}

class ChangeRememberMeState extends JobFinderState {}

class SelectedJobTypeCardState extends JobFinderState {}

class SelectedJobCountryLocationState extends JobFinderState {}

class AuthLoginLoadingState extends JobFinderState {}

class AuthLoginSuccessState extends JobFinderState {
  final String userID;
  AuthLoginSuccessState(this.userID);
}

class AuthLoginErrorState extends JobFinderState {
  final String error;
  AuthLoginErrorState(this.error);
}

class AuthLoginGoogleLoadingState extends JobFinderState {}

class AuthLoginGoogleSuccessState extends JobFinderState {
  final String userID;
  AuthLoginGoogleSuccessState(this.userID);
}

class AuthLoginGoogleErrorState extends JobFinderState {
  final String error;
  AuthLoginGoogleErrorState(this.error);
}

class AuthSignOutLoadingState extends JobFinderState {}

class AuthSignOutSuccessState extends JobFinderState {}

class AuthSignOutErrorState extends JobFinderState {
  final String error;
  AuthSignOutErrorState(this.error);
}

class AuthSignUpLoadingState extends JobFinderState {}

class AuthSignUpSuccessState extends JobFinderState {
  final String userID;
  AuthSignUpSuccessState(this.userID);
}

class AuthSignUpErrorState extends JobFinderState {
  final String error;
  AuthSignUpErrorState(this.error);
}

class AuthRestPasswordLoadingState extends JobFinderState {}

class AuthRestPasswordSuccessState extends JobFinderState {}

class AuthRestPasswordErrorState extends JobFinderState {
  final String error;
  AuthRestPasswordErrorState(this.error);
}

class CreateUserDocLoadingState extends JobFinderState {}

class CreateUserDocSuccessState extends JobFinderState {}

class CreateUserDocErrorState extends JobFinderState {
  final String error;
  CreateUserDocErrorState(this.error);
}

class GetUserDataLoadingState extends JobFinderState {}

class GetUserDataSuccessState extends JobFinderState {}

class GetUserDataErrorState extends JobFinderState {
  final String error;
  GetUserDataErrorState(this.error);
}

class UpdateUserDocLoadingState extends JobFinderState {}

class UpdateUserDocSuccessState extends JobFinderState {}

class UpdateUserDocErrorState extends JobFinderState {
  final String error;
  UpdateUserDocErrorState(this.error);
}

class UpdateUserPasswordLoadingState extends JobFinderState {}

class UpdateUserPasswordSuccessState extends JobFinderState {}

class UpdateUserPasswordErrorState extends JobFinderState {
  final String error;
  UpdateUserPasswordErrorState(this.error);
}

// class DeleteUserDataLoadingState extends JobFinderState {}

// class DeleteUserDataSuccessState extends JobFinderState {}

// class DeleteUserDataErrorState extends JobFinderState {
//   final String error;
//   DeleteUserDataErrorState(this.error);
// }

class ChangeStepsState extends JobFinderState {}

class GetApiLoadingState extends JobFinderState {}

class GetApiSuccessState extends JobFinderState {}

class GetApiErrorState extends JobFinderState {
  final String error;
  GetApiErrorState(this.error);
}

class GetApiChatState extends JobFinderState {}

class GetApiChatSuccessState extends JobFinderState {}

class GetApiChatErrorState extends JobFinderState {
  final String error;
  GetApiChatErrorState(this.error);
}

class GetApiSearchLoadingState extends JobFinderState {}

class GetApiSearchSuccessState extends JobFinderState {}

class GetApiSearchErrorState extends JobFinderState {
  final String error;
  GetApiSearchErrorState(this.error);
}

class ImagePickerLoadingState extends JobFinderState {}

class ImagePickerSuccessState extends JobFinderState {}

class FilePickerLoadingState extends JobFinderState {}

class FilePickerSuccessState extends JobFinderState {}

class ChangeSelectedLanguageState extends JobFinderState {}

class ChangeJobNotificationSettingState extends JobFinderState {}

class FilterChoiceChipState extends JobFinderState {}
