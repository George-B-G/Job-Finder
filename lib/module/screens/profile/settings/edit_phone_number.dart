import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPhoneNumberScreen extends StatelessWidget {
  EditPhoneNumberScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        if (state is UpdateUserDocSuccessState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green.shade300,
              content: const Text('Phone number has been Changed'),
            ),
          );
        } else if (state is UpdateUserDocErrorState) {
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
        phoneController.text = cubit.userModel?.phone ?? '';
        return Scaffold(
          appBar: appbarWithLogo(
            title: 'Phone number',
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  customTextField(
                    onTapFunction: () {},
                    onChangeFunction: (value) {},
                    prefixIconData: const Icon(Icons.phone),
                    hinttextValue: 'Phone number',
                    keyboardTextInputType: TextInputType.phone,
                    textEditingController: phoneController,
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
                          cubit.updateUserDocFunction(updateMap: {
                            'phone': phoneController.text,
                          });
                        }
                      },
                      child: Text(
                        'Save',
                        style: Theme.of(context).primaryTextTheme.labelLarge,
                      ),
                    ),
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
