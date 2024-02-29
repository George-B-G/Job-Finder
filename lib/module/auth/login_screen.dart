import 'package:amit_job_finder/layout/layout.dart';
import 'package:amit_job_finder/module/auth/forget_password_screen.dart';
import 'package:amit_job_finder/module/auth/sign_up_screen.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:amit_job_finder/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passowrdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        if (state is AuthLoginErrorState) {
          // print('Error has happened ${state.error}');
        } else if (state is AuthLoginSuccessState) {
          CacheHelper.putStringData(key: 'uid', value: state.userID)
              .then((val) {
            userId = state.userID;
            JobFinderCubit.get(context).getApiData();
            JobFinderCubit.get(context).getUserDataFunction();
            pushReplacementToPage(
              context: context,
              screenName: const LayoutScreen(),
            );
          });
        }
        if (state is AuthLoginGoogleErrorState) {
          // print('Error has happened ${state.error}');
        } else if (state is AuthLoginGoogleSuccessState) {
          CacheHelper.putStringData(key: 'uid', value: state.userID)
              .then((val) {
            userId = state.userID;
              // JobFinderCubit.get(context).getChatApiData();
               JobFinderCubit.get(context).getApiData();
            JobFinderCubit.get(context).getUserDataFunction();
            pushReplacementToPage(
              context: context,
              screenName: const LayoutScreen(),
            );
          });
        }
      },
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appbarWithLogo(showingAction: true),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCustomTitle(
                    title: 'Login',
                    subTitle: 'Please Login to find your dream job',
                  ),
                  verticalSpace(
                    value: 3,
                  ),
                  // username text form field
                  customTextField(
                                        onTapFunction: (){},
                    textEditingController: usernameController,
                    hinttextValue: 'Username',
                    
                    prefixIconData: const Icon(Icons.person),
                    keyboardTextInputType: TextInputType.emailAddress,
                    onChangeFunction: (value){},
                    validatorFunction: (String val) {
                      if (val.isEmpty) {
                        return 'Enter a username';
                      } else {
                        return null;
                      }
                    },
                  ),
                  verticalSpace(
                    value: 1,
                  ),
                  // password text form field
                  customTextField(
                                        onTapFunction: (){},
                    textEditingController: passowrdController,
                    hinttextValue: 'Password',
                    prefixIconData: const Icon(Icons.lock),
                    onChangeFunction: (value){},
                    keyboardTextInputType: TextInputType.visiblePassword,
                    isObsecureText: cubit.isPasswordVisible,
                    suffixIconData: IconButton(
                      icon: Icon(cubit.passwordVisibilityIcon),
                      onPressed: () => cubit.changePasswordVisibility(),
                    ),
                    validatorFunction: (String val) {
                      if (val.isEmpty) {
                        return 'Password must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),

                  //to reset password or remember me action
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          value: cubit.rememberMe,
                          onChanged: (val) =>
                              cubit.changeRememberMeAction(val!),
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.all(0),
                          dense: true,
                          title: const Text('Remember me'),
                          splashRadius: 0,
                          visualDensity: VisualDensity.comfortable,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          'Forget Password?',
                          style: Theme.of(context).primaryTextTheme.labelMedium,
                        ),
                        onTap: () {
                          pushToPage(
                            context: context,
                            screenName: ForgetPasswordScreen(),
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  fastNavigatorLink(
                    // to register a new account
                    buttonStyleVal:
                        Theme.of(context).primaryTextTheme.labelMedium,
                    context: context,
                    text: 'don\'t have an account? ',
                    buttonTitle: 'Register',
                    onPress: () {
                      pushToPage(
                        context: context,
                        screenName: SignUpScreen(),
                      );
                    },
                  ),
                  verticalSpace(value: 1),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.userLoginFunction(
                            email: usernameController.text,
                            password: passowrdController.text,
                          );
                        }
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).primaryTextTheme.labelLarge,
                      ),
                    ),
                  ),
                  verticalSpace(value: 1),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Text(
                        " OR Login with Account ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  verticalSpace(value: 1),
                  // to loign with google or facebook
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      accessWithFacebookOrGoogle(
                        title: 'Google',
                        image: googleLogo,
                        ontap: () => cubit.signInWithGoogle(),
                      ),
                      horizontalSpace(value: 1),
                      accessWithFacebookOrGoogle(
                        title: 'Facebook',
                        iconData: Icons.facebook,
                        ontap: () => cubit.signInWithFacebook(),
                      ),
                    ],
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
