import 'package:amit_job_finder/layout/layout.dart';
import 'package:amit_job_finder/module/auth/login_screen.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:amit_job_finder/shared/components/current_user_state.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        if (state is AuthRestPasswordErrorState) {
          // print('error has happened ${state.error}');
        } else if (state is AuthRestPasswordSuccessState) {
          pushReplacementToPage(
            context: context,
            screenName: CurrentUserState(
              image: 'assets/images/access_state/EmailIlustration.png',
              title: 'Check your Email',
              subTitle: 'We have sent a reset password to your email address',
              buttonTitle: 'Open email app',
              goToScreen: const LayoutScreen(),
              key: key,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return Scaffold(
          appBar: appbarWithLogo(showingAction: true),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formkey,
              child: Stack(
                children: [
                  buildCustomTitle(
                    title: 'Reset Password',
                    subTitle:
                        'Enter the email address you used when you joined and we\'ll send you instructions to reset your password.',
                  ),
                  verticalSpace(value: 3),
                  Positioned(
                    left: screenDefaultSize * 1,
                    right: screenDefaultSize * 1,
                    top: screenDefaultSize * 15,
                    child: customTextField(
                      onTapFunction: () {},
                      textEditingController: emailController,
                      hinttextValue: 'Enter your email...',
                      prefixIconData: const Icon(Icons.email_outlined),
                      keyboardTextInputType: TextInputType.emailAddress,
                      onChangeFunction: (value) {},
                      validatorFunction: (String val) {
                        if (val.isEmpty) {
                          return 'must not be empty';
                        } else if (val.contains('@') == false) {
                          return 'email missing @ sign';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: screenDefaultSize * 10,
                    child: fastNavigatorLink(
                      buttonStyleVal:
                          Theme.of(context).primaryTextTheme.labelMedium,
                      text: 'You remember your password ',
                      buttonTitle: 'Login',
                      onPress: () {
                        pushReplacementToPage(
                          context: context,
                          screenName: LoginScreen(),
                        );
                      },
                      context: context,
                    ),
                  ),
                  Positioned(
                    left: screenDefaultSize * 1,
                    right: screenDefaultSize * 1,
                    bottom: screenDefaultSize * 3,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          cubit.userResetPasswordFuntion(
                              email: emailController.text);
                        }
                      },
                      child: Text(
                        'Request password reset',
                        style: Theme.of(context).primaryTextTheme.labelLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
