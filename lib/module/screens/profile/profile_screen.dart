import 'package:amit_job_finder/module/auth/login_screen.dart';
import 'package:amit_job_finder/module/screens/profile/settings/edit_profile_screen.dart';
import 'package:amit_job_finder/module/screens/profile/settings/language_screen.dart';
import 'package:amit_job_finder/module/screens/profile/settings/login_security_screen.dart';
import 'package:amit_job_finder/module/screens/profile/settings/notification_settings_screen.dart';
import 'package:amit_job_finder/module/screens/profile/settings/others_screen.dart';
import 'package:amit_job_finder/module/screens/profile/settings/protfolio_screen.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  List<Map> generalList = [
    {
      'icon': Icons.person_outline,
      'title': 'Edit Profile',
      'screen': EditScreen(),
    },
    {
      'icon': Icons.folder_shared_outlined,
      'title': 'Protfolio',
      'screen': const ProtofolioScreen(),
    },
    {
      'icon': Icons.language,
      'title': 'Language',
      'screen': const LanguageScreen(),
    },
    {
      'icon': Icons.notifications_outlined,
      'title': 'Notification',
      'screen': const NotificationSettingScreen(),
    },
    {
      'icon': Icons.lock_outline,
      'title': 'Login and security',
      'screen': const LoginSecurityScreen(),
    },
  ];
  List<Map> othersList = [
    {
      'screenTitle': 'Accessbility',
      'firstTitle': 'Accessbility',
      'firstcontent': 'Accessbility',
      'secTitle': 'Accessbility',
      'secContent': 'Accessbility',
    },
    {
      'screenTitle': 'Help center',
      'firstTitle': 'Help center',
      'firstcontent': 'Help center',
      'secTitle': 'Help center',
      'secContent': 'Help center',
    },
    {
      'screenTitle': 'Terms & conditions',
      'firstTitle': 'Lorem ipsum dolor',
      'firstcontent':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vel augue sit amet est molestie viverra. Nunc quis bibendum orci. Donec feugiat massa mi, at hendrerit mauris rutrum at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vel augue sit amet est molestie viverra. Nunc quis bibendum orci. Donec feugiat massa mi, at hendrerit mauris rutrum at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vel augue sit amet est molestie viverra. Nunc quis bibendum orci. Donec feugiat massa mi, at hendrerit mauris rutrum at. ',
      'secTitle': 'Lorem ipsum dolor',
      'secContent':
          'Nunc quis bibendum orci. Donec feugiat massa mi, at hendrerit mauris rutrum at. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'screenTitle': 'Privacy Policy',
      'firstTitle': 'Your privacy is important',
      'firstcontent':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vel augue sit amet est molestie viverra. Nunc quis bibendum orci. Donec feugiat massa mi, at hendrerit mauris rutrum at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vel augue sit amet est molestie viverra. Nunc quis bibendum orci. Donec feugiat massa mi, at hendrerit mauris rutrum at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vel augue sit amet est molestie viverra. Nunc quis bibendum orci. Donec feugiat massa mi, at hendrerit mauris rutrum at. ',
      'secTitle': 'Data controllers and contract partners',
      'secContent':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vel augue sit amet est molestie viverra. Nunc quis bibendum orci. Donec feugiat massa mi, at hendrerit mauris rutrum at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vel augue sit amet est molestie viverra. Nunc quis bibendum orci. Donec feugiat massa mi, at hendrerit mauris rutrum at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vel augue sit amet est molestie viverra. Nunc quis bibendum orci. Donec feugiat massa mi, at hendrerit mauris rutrum at. ',
    },
  ];
  final double coverHeight = 200;
  final double profileHeight = 130;
  TextEditingController editAboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        if (state is AuthSignOutErrorState) {
          print('error in log-out ${state.error}');
        } else if (state is AuthSignOutSuccessState) {
          pushReplacementToPage(context: context, screenName: LoginScreen());
        }
      },
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return ListView(children: [
          buildTopWithProfileImage(
            cubitVariable: cubit,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                Text(
                  cubit.userModel?.name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                verticalSpace(
                  value: 1,
                ),
                Text(
                  cubit.userModel?.bio ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 60,
                  color: Colors.grey.shade100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildReviewItem(
                          text: 'Applied',
                          value: '${cubit.userModel!.appliedJobList!.length}'),
                      const VerticalDivider(),
                      buildReviewItem(text: 'Reviewed', value: '66'),
                      const VerticalDivider(),
                      buildReviewItem(
                          text: 'contacted',
                          value: '${cubit.apiChatData.length}'),
                    ],
                  ),
                ),
                fastNavigatorLink(
                  context: context,
                  mainAxisAlignmentVal: MainAxisAlignment.spaceBetween,
                  text: 'About',
                  styleVal: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  buttonTitle: 'Edit',
                  buttonStyleVal:
                      Theme.of(context).primaryTextTheme.labelMedium,
                  onPress: () {
                    editAboutController.text = cubit.userModel?.about ?? '';
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('About'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            customTextField(
                              hinttextValue: 'About',
                              textEditingController: editAboutController,
                              maxFieldLines: 5,
                              minFieldLines: 1,
                              onChangeFunction: (value) {},
                              onTapFunction: () {},
                            ),
                            verticalSpace(
                              value: 2,
                            ),
                            ElevatedButton(
                              child: const Text(
                                'Save edit',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                cubit.updateUserDocFunction(updateMap: {
                                  'about': editAboutController.text,
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                verticalSpace(
                  value: 1,
                ),
                Text(cubit.userModel?.about ?? ''),
                verticalSpace(
                  value: 1,
                ),
              ],
            ),
          ),
          screenSeparator(title: 'General'),
          buildListViewSeparator(
            count: generalList.length,
            itemBuilderVal: (context, index) => ListTile(
              title: Text(generalList[index]['title']),
              leading: CircleAvatar(
                  child: Icon(
                generalList[index]['icon'],
                color: const Color(0xff3366FF),
              )),
              trailing: const Icon(
                Icons.arrow_forward,
              ),
              onTap: () => pushToPage(
                  context: context, screenName: generalList[index]['screen']),
            ),
          ),
          screenSeparator(title: 'Others'),
          buildListViewSeparator(
            count: othersList.length,
            itemBuilderVal: (context, index) => ListTile(
              title: Text(othersList[index]['screenTitle']),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => pushToPage(
                context: context,
                screenName: OtherScreen(
                  appBarTitle: othersList[index]['screenTitle'],
                  firstTitle: othersList[index]['firstTitle'],
                  firstContent: othersList[index]['firstcontent'],
                  secondTitle: othersList[index]['secTitle'],
                  secondContent: othersList[index]['secContent'],
                ),
              ),
            ),
          ),
        ]);
      },
    );
  }

  Widget buildReviewItem({
    required String text,
    required String value,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget buildTopWithProfileImage({
    required JobFinderCubit cubitVariable,
  }) {
    final double positionTop = coverHeight - profileHeight / 2;
    final double bottomSpace = profileHeight / 2;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: bottomSpace),
            child: Container(
              color: const Color(0xffD6E4FF),
              width: double.infinity,
              height: coverHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  horizontalSpace(value: 6),
                  const Expanded(
                    child: Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => cubitVariable.userSignOutFunction(),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: positionTop,
            child: ClipOval(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(3),
                child: CircleAvatar(
                  radius: profileHeight / 2,
                  backgroundImage: NetworkImage(
                    cubitVariable.userModel?.image ??
                        'https://th.bing.com/th/id/OIP.gV1cXI_SNBK_nU1yrE_hcwHaGp?w=193&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                  ),
                ),
              ),
            ),
          ),
        ]);
  }
}
