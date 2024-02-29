import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatelessWidget {
  EditScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        if (state is GetUserDataSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        nameController.text = cubit.userModel?.name ?? '';
        bioController.text = cubit.userModel?.bio ?? '';
        addressController.text = cubit.userModel?.address ?? '';
        phoneController.text = cubit.userModel?.phone ?? '';
        return Scaffold(
          appBar: appbarWithLogo(
            title: 'Edit profile',
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          cubit.userModel!.image!.isNotEmpty
                              ? cubit.userModel!.image!
                              : (cubit.imageURL == null
                                  ? 'https://th.bing.com/th/id/OIP.gV1cXI_SNBK_nU1yrE_hcwHaGp?w=193&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7'
                                  : cubit.imageURL!),
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Text(
                        'Change photo',
                        style: Theme.of(context).primaryTextTheme.labelMedium,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text('Open camera'),
                                leading: const Icon(Icons.camera_alt_outlined),
                                onTap: () =>
                                    cubit.getImage(isCameraPhoto: true),
                              ),
                              ListTile(
                                title: const Text('Open Gallery'),
                                leading:
                                    const Icon(Icons.photo_library_outlined),
                                onTap: () =>
                                    cubit.getImage(isCameraPhoto: false),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  verticalSpace(value: 3),
                  Text(
                    'Name',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500),
                  ),
                  customTextField(
                    hinttextValue: 'name',
                    textEditingController: nameController,
                    keyboardTextInputType: TextInputType.name,
                    onTapFunction: () {},
                    onChangeFunction: (value) {},
                  ),
                  verticalSpace(value: 1),
                  Text(
                    'bio',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500),
                  ),
                  customTextField(
                    hinttextValue: 'bio',
                    textEditingController: bioController,
                    keyboardTextInputType: TextInputType.text,
                    onTapFunction: () {},
                    onChangeFunction: (value) {},
                  ),
                  verticalSpace(value: 1),
                  Text(
                    'Address',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500),
                  ),
                  customTextField(
                    hinttextValue: 'Address',
                    textEditingController: addressController,
                    keyboardTextInputType: TextInputType.streetAddress,
                    onTapFunction: () {},
                    onChangeFunction: (value) {},
                  ),
                  verticalSpace(value: 1),
                  Text(
                    'No.Handphone',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500),
                  ),
                  customTextField(
                    hinttextValue: 'phone number',
                    textEditingController: phoneController,
                    keyboardTextInputType: TextInputType.phone,
                    onTapFunction: () {},
                    onChangeFunction: (value) {},
                  ),
                  verticalSpace(
                    value: 3,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'Saved',
                        style: Theme.of(context).primaryTextTheme.labelLarge,
                      ),
                      onPressed: () => cubit.updateUserDocFunction(updateMap: {
                        'image': cubit.imageURL,
                        'name': nameController.text,
                        'bio': bioController.text,
                        'address': addressController.text,
                        'phone': phoneController.text
                      }),
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
