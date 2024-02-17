import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({super.key});

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController passowrdController = TextEditingController();
  TextEditingController confirmPassowrdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return Scaffold(
          appBar: appbarWithLogo(showingAction: true),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                buildCustomTitle(
                  title: 'Create new password',
                  subTitle:
                      'Set your new password so you can login and acces Jobsque',
                ),
                verticalSpace(value: 3),
                Positioned(
                  left: screenDefaultSize * 1,
                  right: screenDefaultSize * 1,
                  top: screenDefaultSize * 11,
                  child: customTextField(
                    onTapFunction: () {},
                    textEditingController: passowrdController,
                    hinttextValue: 'Enter new password',
                    prefixIconData: const Icon(Icons.lock),
                    keyboardTextInputType: TextInputType.visiblePassword,
                    isObsecureText: cubit.isPasswordVisible,
                    suffixIconData: IconButton(
                        onPressed: () => cubit.changePasswordVisibility(),
                        icon: Icon(cubit.passwordVisibilityIcon)),
                    onChangeFunction: (value) {},
                    validatorFunction: (String val) {
                      if (val.isEmpty && val.length < 8) {
                        return 'must not be empty or less than 8 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Positioned(
                  left: screenDefaultSize * 1,
                  right: screenDefaultSize * 1,
                  top: screenDefaultSize * 20,
                  child: customTextField(
                    onTapFunction: () {},
                    textEditingController: confirmPassowrdController,
                    hinttextValue: 'Enter new password again',
                    prefixIconData: const Icon(Icons.lock),
                    keyboardTextInputType: TextInputType.visiblePassword,
                    isObsecureText: cubit.isPasswordVisible,
                    suffixIconData: IconButton(
                      icon: Icon(cubit.passwordVisibilityIcon),
                      onPressed: () => cubit.changePasswordVisibility(),
                    ),
                    onChangeFunction: (value) {},
                    validatorFunction: (String val) {
                      if (val.isEmpty && val.length < 8) {
                        return 'must not be empty or less than 8 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Positioned(
                  left: screenDefaultSize * 1,
                  right: screenDefaultSize * 1,
                  bottom: screenDefaultSize * 3,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        if (passowrdController.text ==
                            confirmPassowrdController.text) {}
                      }
                      // pushReplacementToPage(
                      //   context: context,
                      //   screenName: CurrentUserState(
                      //     key: key,
                      //     image:
                      //         'assets/images/access_state/PasswordSuccesfullyIlustration.png',
                      //     title: 'Password changed succesfully!',
                      //     subTitle:
                      //         'Your password has been changed successfully, we will let you know if there are more problems with your account',
                      //     buttonTitle: 'Open email app',
                      //     goToScreen: LoginScreen(),
                      //   ),
                      // );
                    },
                    child: Text(
                      'Reset password',
                      style: Theme.of(context).primaryTextTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
