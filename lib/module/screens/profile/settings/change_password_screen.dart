import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        if (state is UpdateUserPasswordSuccessState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green.shade300,
              content: const Text('Password has been Changed'),
              action: SnackBarAction(
                label: 'Logout',
                textColor: Colors.white,
                onPressed: () =>
                    JobFinderCubit.get(context).userSignOutFunction(),
              ),
            ),
          );
        } else if (state is UpdateUserPasswordErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red.shade300,
              content: Text(
                state.error,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return Scaffold(
          appBar: appbarWithLogo(
            title: 'Change Password',
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  customTextField(
                    onTapFunction: () {},
                    prefixIconData: const Icon(Icons.lock),
                    hinttextValue: 'Enter your old password',
                    onChangeFunction: (value) {},
                    textEditingController: oldPasswordController,
                    validatorFunction: (String val) {
                      if (val.isEmpty) {
                        return 'Password must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  verticalSpace(value: 1.5),
                  customTextField(
                    onTapFunction: () {},
                    onChangeFunction: (value) {},
                    textEditingController: newPasswordController,
                    prefixIconData: const Icon(Icons.lock),
                    hinttextValue: 'Enter your new password',
                    validatorFunction: (String val) {
                      if (val.isEmpty) {
                        return 'Password must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  verticalSpace(value: 1.5),
                  customTextField(
                    onTapFunction: () {},
                    onChangeFunction: (value) {},
                    textEditingController: confirmPasswordController,
                    prefixIconData: const Icon(Icons.lock),
                    hinttextValue: 'confirm your new password',
                    validatorFunction: (String val) {
                      if (val.isEmpty) {
                        return 'Password must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (newPasswordController.text ==
                                confirmPasswordController.text) {
                              cubit.updateUserPasswordFunction(
                                  newPassword: confirmPasswordController.text);
                            }
                          }
                        },
                        child: Text(
                          'Save',
                          style: Theme.of(context).primaryTextTheme.labelLarge,
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
