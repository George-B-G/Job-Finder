import 'package:amit_job_finder/module/auth/login_screen.dart';
import 'package:amit_job_finder/module/auth/sign_up_info.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:amit_job_finder/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        var cubit = JobFinderCubit.get(context);
        if (state is AuthSignUpErrorState) {
          // print('error in sign up ${state.error}');
        } else if (state is AuthSignUpSuccessState) {
          CacheHelper.putStringData(key: 'uid', value: state.userID)
              .then((val) {
            userId = state.userID;
            cubit.country.any((element) => element['selected'] == true
                ? element['selected'] = false
                : element['selected'] = false);
            cubit.jobCardList.any((element) => element['selected'] == true
                ? element['selected'] = false
                : element['selected'] = false);

            pushReplacementToPage(
              context: context,
              screenName: TypeOfWorkScreen(),
            );
          });
        }
        if (state is AuthLoginGoogleErrorState) {
          // print('error in sign up ${state.error}');
        } else if (state is AuthLoginGoogleSuccessState) {
          CacheHelper.putStringData(key: 'uid', value: state.userID)
              .then((val) {
            userId = state.userID;
            cubit.country.any((element) => element['selected'] == true
                ? element['selected'] = false
                : element['selected'] = false);
            cubit.jobCardList.any((element) => element['selected'] == true
                ? element['selected'] = false
                : element['selected'] = false);
            pushReplacementToPage(
              context: context,
              screenName: TypeOfWorkScreen(),
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
                    title: 'Create Account',
                    subTitle: 'Please Create an account to find your dream job',
                  ),
                  verticalSpace(
                    value: 3,
                  ),
                  // username text form field
                  customTextField(
                    onTapFunction: () {},
                    onChangeFunction: (value) {},
                    textEditingController: usernameController,
                    hinttextValue: 'Username',
                    prefixIconData: const Icon(Icons.person),
                    keyboardTextInputType: TextInputType.name,
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
                  // email text form field
                  customTextField(
                    onTapFunction: () {},
                    onChangeFunction: (value) {},
                    textEditingController: emailController,
                    hinttextValue: 'Email',
                    prefixIconData: const Icon(Icons.email),
                    keyboardTextInputType: TextInputType.emailAddress,
                    validatorFunction: (String val) {
                      if (val.isEmpty) {
                        return 'Email must not be empty';
                      } else if (val.contains('@') == false) {
                        return 'missing @ sign';
                      } else {
                        return null;
                      }
                    },
                  ),
                  verticalSpace(value: 1),
                  // password text form field

                  customTextField(
                    onTapFunction: () {},
                    onChangeFunction: (value) {},
                    textEditingController: passwordController,
                    hinttextValue: 'Password',
                    prefixIconData: const Icon(Icons.lock),
                    keyboardTextInputType: TextInputType.visiblePassword,
                    isObsecureText: cubit.isPasswordVisible,
                    suffixIconData: IconButton(
                      onPressed: () => cubit.changePasswordVisibility(),
                      icon: Icon(cubit.passwordVisibilityIcon),
                    ),
                    validatorFunction: (String val) {
                      if (val.isEmpty || val.length < 8) {
                        return 'Password must be at least 8 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  // verticalSpace(value: 13),
                  const Expanded(child: SizedBox()),
                  fastNavigatorLink(
                    buttonStyleVal:
                        Theme.of(context).primaryTextTheme.labelMedium,
                    context: context,
                    text: 'Already have an account? ',
                    buttonTitle: 'Login',
                    onPress: () {
                      pushReplacementToPage(
                        context: context,
                        screenName: LoginScreen(),
                      );
                    },
                  ),
                  verticalSpace(value: 1),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.userSignUpFunction(
                            email: emailController.text,
                            username: usernameController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                      child: Text(
                        'Create an account',
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
                  // to sign up with google or facebook
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
