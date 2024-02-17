class UserModel {
  String? uid,
      name,
      email,
      phone,
      image,
      bio,
      about,
      address,
      language,
      workFromHomeOrRemote;
  List? preferredLocation, typeOfWork, savedJobList, userCV, appliedJobList,userNotification;
  bool? isEmailVerified;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.language,
    required this.typeOfWork,
    required this.preferredLocation,
    required this.userNotification,
    required this.savedJobList,
    required this.appliedJobList,
    required this.bio,
    required this.about,
    required this.address,
    required this.image,
    required this.userCV,
    required this.phone,
    required this.isEmailVerified,
    required this.workFromHomeOrRemote,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['userID'];
    name = json['name'];
    email = json['email'];
    userNotification = json['userNotification'];
    image = json['image'];
    bio = json['bio'];
    language = json['language'];
    address = json['address'];
    appliedJobList = json['appliedJobList'];
    about = json['about'];
    userCV = json['userCV'];
    isEmailVerified = json['isEmailVerified'];
    phone = json['phone'];
    workFromHomeOrRemote = json['workFromHomeOrRemote'];
    typeOfWork = json['type_of_work'];
    preferredLocation = json['preferred_location'];
    savedJobList = json['savedJobList'];
  }

  Map<String, dynamic> toMap() => {
        'userID': uid,
        'name': name,
        'email': email,
        'image': image,
        'userCV': userCV,
        'userNotification': userNotification,
        'about': about,
        'language': language,
        'appliedJobList': appliedJobList,
        'bio': bio,
        'address': address,
        'isEmailVerified': isEmailVerified,
        'phone': phone,
        'type_of_work': typeOfWork,
        'preferred_location': preferredLocation,
        'workFromHomeOrRemote': workFromHomeOrRemote,
        'savedJobList': savedJobList,
      };
}
