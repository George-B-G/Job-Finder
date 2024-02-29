import 'package:amit_job_finder/module/screens/chat/chat_screen.dart';
import 'package:amit_job_finder/module/screens/home/home_screen.dart';
import 'package:amit_job_finder/module/screens/profile/profile_screen.dart';
import 'package:amit_job_finder/module/screens/save_and_apply/applied_screen.dart';
import 'package:amit_job_finder/module/screens/save_and_apply/saves_screen.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:amit_job_finder/shared/network/local/cache_helper.dart';
import 'package:amit_job_finder/shared/network/remote/dio_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:amit_job_finder/model/user_model.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobFinderCubit extends Cubit<JobFinderState> {
  JobFinderCubit() : super(JobFinderInitialState());
  static JobFinderCubit get(context) => BlocProvider.of(context);

// control bottom navigation bar
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavigationBarItem = const [
    BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
    BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Applied'),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];
  List<Widget> screens = [
    HomeScreen(),
    MessageScreen(),
    const AppliedScreen(),
    const SavedScreen(),
    ProfileScreen(),
  ];
  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }

  // used in applied job screen to change tab bar
  int tabBarIndex = 0;
  int jobDetailIndex = 0;
  String activeOrRejected = 'Active';
  String jobDetail = 'Desicription';

  void changeActiveOrRejectedIndex(int index) {
    tabBarIndex = index;
    index == 0 ? activeOrRejected = 'Active' : activeOrRejected = 'Rejected';
    emit(ChangeActiveOrRejectedTabBarIndexState());
  }

  void changeJobDetailTabBarIndex(int index) {
    jobDetailIndex = index;
    index == 0
        ? jobDetail = 'Desicription'
        : (index == 1 ? jobDetail = 'Company' : jobDetail = 'People',);
    emit(ChangeJobDetailTabBarIndexStateState());
  }

//change password visibility
  bool isPasswordVisible = true;
  IconData passwordVisibilityIcon = Icons.visibility_off_outlined;
  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    passwordVisibilityIcon = isPasswordVisible
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }

// change login remember me action
  bool rememberMe = false;
  void changeRememberMeAction(bool val) {
    rememberMe = val;
    CacheHelper.putBoolData(key: 'rememberMe', value: rememberMe);
    emit(ChangeRememberMeState());
  }

// selected type of work and country
  bool isJobSelectd = false;
  int selectedCountryIndex = 0;
  List<Map> country = [
    {
      'name': "United States",
      'image': 'assets/images/flags/usa.png',
      'selected': false,
    },
    {
      'name': "Malaysia",
      'image': 'assets/images/flags/malasysia.png',
      'selected': false,
    },
    {
      'name': "Singapore",
      'image': 'assets/images/flags/singapore.png',
      'selected': false,
    },
    {
      'name': "Indonesia",
      'image': 'assets/images/flags/indonesia.png',
      'selected': false,
    },
    {
      'name': "Philiphines",
      'image': 'assets/images/flags/philiphines.png',
      'selected': false,
    },
    {
      'name': "Polandia",
      'image': 'assets/images/flags/polandia.png',
      'selected': false,
    },
    {
      'name': "India",
      'image': 'assets/images/flags/india.png',
      'selected': false,
    },
    {
      'name': "China",
      'image': 'assets/images/flags/china.png',
      'selected': false,
    },
    {
      'name': "Vietnam",
      'image': 'assets/images/flags/vietnam.png',
      'selected': false,
    },
    {
      'name': "Canda",
      'image': 'assets/images/flags/canda.png',
      'selected': false,
    },
    {
      'name': "Saudi Arabia",
      'image': 'assets/images/flags/saudi_arabia.png',
      'selected': false,
    },
    {
      'name': "Brazil",
      'image': 'assets/images/flags/brazil.png',
      'selected': false,
    },
    {
      'name': "Argentina",
      'image': 'assets/images/flags/argentina.png',
      'selected': false,
    },
  ];
  List<Map> jobCardList = [
    {
      'name': 'UI/UX Designer',
      'icon': Icons.design_services_outlined,
      'selected': false,
    },
    {
      'name': 'Illustrator Designer',
      'icon': Icons.draw_outlined,
      'selected': false,
    },
    {
      'name': 'Developer',
      'icon': Icons.developer_mode_outlined,
      'selected': false,
    },
    {
      'name': 'Management',
      'icon': Icons.pie_chart,
      'selected': false,
    },
    {
      'name': 'Information Technology',
      'selected': false,
      'icon': Icons.computer,
    },
    {
      'name': 'Research and Analytics',
      'icon': Icons.cloud_done_outlined,
      'selected': false,
    },
  ];
  void changeSelectedJobType({required int index}) {
    jobCardList[index]['selected'] = (isJobSelectd = !isJobSelectd);
    // print(isJobSelectd);
    emit(SelectedJobTypeCardState());
  }

  void changeSelectedCountryLocation({
    required bool isSelectedCountry,
    required int index,
  }) {
    selectedCountryIndex = isSelectedCountry ? index : 0;
    country[index]['selected'] = isSelectedCountry;
    emit(SelectedJobCountryLocationState());
  }

  List filterChoiceChip = [
    {
      'name': 'Full time',
      'selected': false,
    },
    {
      'name': 'Remote',
      'selected': false,
    },
    {
      'name': 'Contract',
      'selected': false,
    },
    {
      'name': 'Part time',
      'selected': false,
    },
    {
      'name': 'Onsite',
      'selected': false,
    },
    {
      'name': 'Internship',
      'selected': false,
    },
  ];
  void changeChoiceChipFilter({
    required bool isSelected,
    required int index,
  }) {
    selectedCountryIndex = isSelected ? index : 0;
    filterChoiceChip[index]['selected'] = isSelected;
    emit(FilterChoiceChipState());
  }

// user Log-in, sign-up, rest-password, create-user-document('users') and get-user-data
  UserModel? userModel;

  userLoginFunction({
    required String email,
    required String password,
  }) async {
    emit(AuthLoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(AuthLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      // print(error.toString());
      emit(AuthLoginErrorState(error.toString()));
    });
  }

  userSignUpFunction({
    required String email,
    required String username,
    required String password,
  }) async {
    emit(AuthSignUpLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreateDocFunction(
        email: email,
        userName: username,
        uid: value.user!.uid,
        verified: value.user!.emailVerified,
      );
      CacheHelper.putBoolData(key: 'rememberMe', value: true);
      emit(AuthSignUpSuccessState(value.user!.uid));
    }).catchError((error) {
      // print(error.toString());
      emit(AuthSignUpErrorState(error.toString()));
    });
  }

  userSignOutFunction() async {
    emit(AuthSignOutLoadingState());
    await FirebaseAuth.instance.signOut().then((value) async {
      GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn() == true) {
        googleSignIn.disconnect();
      }
      CacheHelper.putBoolData(key: 'rememberMe', value: false);
      emit(AuthSignOutSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(AuthSignOutErrorState(error.toString()));
    });
  }

  userCreateDocFunction({
    required String email,
    required String userName,
    required String uid,
    required bool verified,
  }) async {
    emit(CreateUserDocLoadingState());
    userModel = UserModel(
      uid: uid,
      email: email,
      name: userName,
      isEmailVerified: verified,
      about: '',
      userNotification: [],
      language: 'English',
      bio: '',
      address: '',
      typeOfWork: [],
      userCV: [],
      preferredLocation: [],
      appliedJobList: [],
      savedJobList: [],
      workFromHomeOrRemote: 'Work from home',
      image: '',
      phone: '',
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel!.toMap())
        .then((value) {
      emit(CreateUserDocSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(CreateUserDocErrorState(error.toString()));
    });
  }

  updateUserDocFunction({
    required Map<String, dynamic> updateMap,
  }) async {
    emit(UpdateUserDocLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(updateMap)
        .then((value) {
      getUserDataFunction();
      emit(UpdateUserDocSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(UpdateUserDocErrorState(error.toString()));
    });
  }

  getUserDataFunction() async {
    emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      // print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  userResetPasswordFuntion({required String email}) async {
    emit(AuthRestPasswordLoadingState());
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      emit(AuthRestPasswordSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(AuthRestPasswordErrorState(error.toString()));
    });
  }

  updateUserPasswordFunction({required String newPassword}) async {
    emit(UpdateUserPasswordLoadingState());
    await FirebaseAuth.instance.currentUser!
        .updatePassword(newPassword)
        .then((value) {
      emit(UpdateUserPasswordSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(UpdateUserPasswordErrorState(error.toString()));
    });
  }

// sign-in with google or facebook
  Future signInWithGoogle() async {
    emit(AuthLoginGoogleLoadingState());
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      // print(value);
      userCreateDocFunction(
        email: value.user!.email!,
        userName: value.user!.displayName!,
        uid: value.user!.uid,
        verified: value.user!.emailVerified,
      );
      CacheHelper.putBoolData(key: 'rememberMe', value: true);
      emit(AuthLoginGoogleSuccessState(value.user!.uid));
    }).catchError((error) {
      // print(error.toString());
      emit(AuthLoginGoogleErrorState(error.toString()));
    });
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

// Interact with API
  List<dynamic> searchData = [];
  List apiData = [];
  List apiChatData = [];

  void getApiData() {
    emit(GetApiLoadingState());
    DioHelper.getData(
      url: 'api/jobs',
      query: {},
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer 7907|6v0wEEcohvBJkQiCs1HXY9yqCsTiMys56ftAsd5g'
      },
      // methodVal: 'GET',
    ).then((value) {
      apiData.clear();
      apiData = value.data['data'];
      // print('*' * 50);
      // print(apiData);
      emit(GetApiSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(GetApiErrorState(error.toString()));
    });
  }

  void getChatApiData() {
    emit(GetApiChatState());
    DioHelper.getData(
      url: 'api/chat',
      query: {
        'user_id': 1,
        'comp_id': 1,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer 7907|6v0wEEcohvBJkQiCs1HXY9yqCsTiMys56ftAsd5g'
      },
      // methodVal: 'GET',
    ).then((value) {
      apiChatData.clear();
      apiChatData = value.data['data'];
      emit(GetApiChatSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(GetApiChatErrorState(error.toString()));
    });
  }

  void getSearchData({
    String? nameValue,
    String? salaryValue,
    String? locationValue,
  }) {
    emit(GetApiSearchLoadingState());
    DioHelper.postData(
      url: 'api/jobs/filter',
      query: {
        "name": nameValue ?? '',
        "salary": salaryValue ?? '',
        "location": locationValue ?? ''
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer 2689|uERlFfnpNd7kwK9x2IvpN6Cf9HDU7QK6weBjeY8i'
      },
    ).then((value) {
      searchData.clear();
      searchData = value.data['data'];
      emit(GetApiSearchSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(GetApiSearchErrorState(error.toString()));
    });
  }

  File? file;
  String? imageURL;
  getImage({
    required bool isCameraPhoto,
  }) async {
    emit(ImagePickerLoadingState());
    final ImagePicker picker = ImagePicker();
    if (isCameraPhoto == false) {
      XFile? imageGallery = await picker.pickImage(source: ImageSource.gallery);
      if (imageGallery != null) {
        file = File(imageGallery.path);
        var imageName = basename(imageGallery.path);
        var refstorage = FirebaseStorage.instance.ref('usersImages/$imageName');
        await refstorage.putFile(file!);
        imageURL = await refstorage.getDownloadURL();
        getUserDataFunction();
        emit(ImagePickerSuccessState());
      } else {
        imageURL = '';
      }
    } else if (isCameraPhoto == true) {
      XFile? photoCamera = await picker.pickImage(source: ImageSource.camera);
      if (photoCamera != null) {
        file = File(photoCamera.path);
        var imageName = basename(photoCamera.path);
        var refstorage = FirebaseStorage.instance.ref('usersImages/$imageName');
        await refstorage.putFile(file!);
        imageURL = await refstorage.getDownloadURL();
        getUserDataFunction();
        emit(ImagePickerSuccessState());
      } else {
        imageURL = '';
      }
    }
  }

  File? resumeFile;
  String? resumeFileURL, resumeName;
  void uploadResumeFile() async {
    emit(FilePickerLoadingState());
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (filePickerResult != null) {
      resumeFile = File(filePickerResult.files.single.path!);
      resumeName = basename(resumeFile!.path);
      var refstorage = FirebaseStorage.instance.ref('usersResume/$resumeName');
      await refstorage.putFile(resumeFile!);
      resumeFileURL = await refstorage.getDownloadURL();
      uploadedResume.add({
        'name': resumeName,
        'link': resumeFileURL,
      });
      emit(FilePickerSuccessState());
      updateUserDocFunction(updateMap: {
        'userCV': uploadedResume,
      });
      getUserDataFunction();
    } else {}
  }

  // change current language
  List<Map> languageList = [
    {'name': 'English', 'src': 'https://flagpedia.net/data/flags/h80/gb.webp'},
    {
      'name': 'Indonesia',
      'src': 'https://flagpedia.net/data/flags/h80/id.webp'
    },
    {'name': 'Arabic', 'src': 'https://flagpedia.net/data/flags/h80/eg.webp'},
    {'name': 'Chinese', 'src': 'https://flagpedia.net/data/flags/h80/cn.webp'},
    {'name': 'Dutch', 'src': 'https://flagpedia.net/data/flags/h80/nl.webp'},
    {'name': 'French', 'src': 'https://flagpedia.net/data/flags/h80/fr.webp'},
    {'name': 'German', 'src': 'https://flagpedia.net/data/flags/h80/de.webp'},
    {'name': 'Japanese', 'src': 'https://flagpedia.net/data/flags/h80/jp.webp'},
    {'name': 'Korean', 'src': 'https://flagpedia.net/data/flags/h80/kr.webp'},
    {
      'name': 'Portuguese',
      'src': 'https://flagpedia.net/data/flags/h80/pt.webp'
    },
  ];
  String selectedLanguageValue = 'English';
  void changeSelectedLanguageFuction(String value) {
    selectedLanguageValue = value;
    updateUserDocFunction(updateMap: {
      'language': selectedLanguageValue,
    });
    emit(ChangeSelectedLanguageState());
  }

  // job notification
  bool jobNotificationOpened = false;
  List<Map> jobNotification = [
    {
      'name': 'Your job search alert',
      'isOpened': false,
    },
    {
      'name': 'job application update',
      'isOpened': false,
    },
    {
      'name': 'job application reminder',
      'isOpened': false,
    },
    {
      'name': 'jobs you maybe interested in',
      'isOpened': false,
    },
    {
      'name': 'job seeker updates',
      'isOpened': false,
    },
  ];
  List<Map> otherNotification = [
    {
      'name': 'show profile',
      'isOpened': false,
    },
    {
      'name': 'all messages',
      'isOpened': false,
    },
    {
      'name': 'messages nudges',
      'isOpened': false,
    },
  ];
  void changeJobNotificationSetting(bool val, int index) {
    jobNotificationOpened = val;
    jobNotification[index]['isOpened'] = jobNotificationOpened;
    emit(ChangeJobNotificationSettingState());
  }

  void changeOtherJobNotificationSetting(bool val, int index) {
    jobNotificationOpened = val;
    otherNotification[index]['isOpened'] = jobNotificationOpened;
    emit(ChangeJobNotificationSettingState());
  }

  // stepper widget used when press on apply for job button
  int currentStep = 0;
  void changeSteps({required int stepsLength, required List lst}) {
    bool isLastStep = (currentStep == stepsLength - 1);
    if (isLastStep) {
      //Do something with this information
      updateUserDocFunction(updateMap: {
        'appliedJobList': lst.toSet(),
      });
    } else {
      currentStep += 1;
      emit(ChangeStepsState());
    }
  }

  void cancelStep() {
    currentStep == 0 ? 0 : currentStep -= 1;
    emit(ChangeStepsState());
  }
}
