import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyForJobScreen extends StatelessWidget {
  ApplyForJobScreen({super.key, required this.data});

  final Map<String, dynamic> data;
  int currentStep = 0;
  TextEditingController fullNameContoller = TextEditingController();
  TextEditingController emailContoller = TextEditingController();
  TextEditingController phoneContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        if (state is UpdateUserDocSuccessState) {
          JobFinderCubit.get(context).currentStep = 0;
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);

        return Scaffold(
          appBar: appbarWithLogo(
                    title: 'Apply job',
                  ),
          body: Column(
            children: [
              verticalSpace(value: 2),
              SizedBox(
                height: screenDefaultSize * 7,
                child: Image(
                  image: NetworkImage(data['image']),
                ),
              ),
              verticalSpace(value: 2),
              Text(
                data['job_type'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                '${data['comp_name']}',
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
              Expanded(
                child: Stepper(
                    physics: const NeverScrollableScrollPhysics(),
                    elevation: 0,
                    connectorThickness: 2,
                    type: StepperType.horizontal,
                    steps: stepList(context: context, cubitVal: cubit),
                    currentStep: cubit.currentStep,
                    onStepCancel: () => cubit.cancelStep(),
                    onStepContinue: () {
                      appliedJobslst.clear();
                      appliedJobslst.add({
                        'fullName': fullNameContoller.text,
                        'email': emailContoller.text,
                        'phone': phoneContoller.text,
                        'data': data,
                      }); // convert to map to save user information and job data
                      cubit.changeSteps(
                        stepsLength:
                            stepList(context: context, cubitVal: cubit).length,
                        lst: appliedJobslst,
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Step> stepList({
    required context,
    required JobFinderCubit cubitVal,
  }) =>
      [
        Step(
          state: cubitVal.currentStep <= 0
              ? StepState.indexed
              : StepState.complete,
          isActive: cubitVal.currentStep >= 0,
          label: const Text('bio'),
          title: const Text(''),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCustomTitle(
                title: 'Biodata',
                subTitle: 'Fill in your bio data correctly',
              ),
              verticalSpace(
                value: 0.5,
              ),
              _myTextFormField(
                textEditingController: fullNameContoller,
                hintTextVal: 'Full name',
                onchangeValue: (value) => fullNameContoller.text = value,
                textInputType: TextInputType.name,
                prefixIconData: Icons.person,
              ),
              verticalSpace(
                value: 0.5,
              ),
              _myTextFormField(
                textEditingController: emailContoller,
                hintTextVal: 'Email',
                onchangeValue: (value) => emailContoller.text = value,
                textInputType: TextInputType.emailAddress,
                prefixIconData: Icons.email,
              ),
              verticalSpace(
                value: 0.5,
              ),
              _myTextFormField(
                textEditingController: phoneContoller,
                hintTextVal: 'Phone',
                onchangeValue: (value) => phoneContoller.text = value,
                textInputType: TextInputType.phone,
                prefixIconData: Icons.phone,
              ),
            ],
          ),
        ),
        Step(
          state: cubitVal.currentStep <= 1
              ? StepState.indexed
              : StepState.complete,
          isActive: cubitVal.currentStep >= 1,
          label: const Text('type of work'),
          title: const Text(''),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCustomTitle(
                title: 'Type of work',
                subTitle: 'Fill in your bio data correctly',
              ),
              RadioListTile(
                dense: true,
                controlAffinity: ListTileControlAffinity.trailing,
                title: const Text('Senior UX Designer'),
                subtitle: const Text('CV.pdf, Protofolio.pdf'),
                value: 0,
                groupValue: 0,
                onChanged: (value) {},
              ),
              RadioListTile(
                dense: true,
                controlAffinity: ListTileControlAffinity.trailing,
                title: const Text('Senior UX Designer'),
                subtitle: const Text('CV.pdf, Protofolio.pdf'),
                value: 0,
                groupValue: 0,
                onChanged: (value) {},
              ),
              RadioListTile(
                dense: true,
                controlAffinity: ListTileControlAffinity.trailing,
                title: const Text('Senior UX Designer'),
                subtitle: const Text('CV.pdf, Protofolio.pdf'),
                value: 0,
                groupValue: 0,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        Step(
          state: cubitVal.currentStep <= 2
              ? StepState.indexed
              : StepState.complete,
          isActive: cubitVal.currentStep >= 2,
          label: const Text('portofolio'),
          title: const Text(''),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildCustomTitle(
                  title: 'Upload portfolio',
                  subTitle: 'Fill in your bio data correctly',
                ),
                verticalSpace(
                  value: 1,
                ),
                _buildUploadingFile(context: context, cubitVal: cubitVal),
                verticalSpace(
                  value: 1,
                ),
                _buildResumeItem(
                  context: context,
                  dataList: cubitVal.userModel!.userCV!,
                ),
              ],
            ),
          ),
        )
      ];

  Widget _buildUploadingFile({
    required context,
    required JobFinderCubit cubitVal,
  }) =>
      DottedBorder(
        color: const Color(0xff3366FF),
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        child: Container(
          width: double.infinity,
          height: 190,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffECF2FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                radius: 25,
                child: Icon(
                  Icons.upload_file_rounded,
                  size: 30,
                  color: Color(0xff3366FF),
                ),
              ),
              const Text(
                'Upload your other file',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                'Max. file size 10MB',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color(0xff3366FF),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      Color(0xffD6E4FF),
                    ),
                  ),
                  onPressed: () => cubitVal.uploadResumeFile(),
                  child: Text(
                    'Add file',
                    style: Theme.of(context).primaryTextTheme.labelMedium,
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildResumeItem({
    required dataList,
    required context,
  }) =>
      buildListViewSeparator(
        count: dataList.length,
        itemBuilderVal: (context, index) => Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text('${dataList[index]['name']}'),
            subtitle: const Text('CV.pdf 300KB'),
            leading: Image.network(
              'https://cdn-icons-png.flaticon.com/128/4726/4726010.png',
              width: 25,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0xFF2E5BE3),
                    )),
                IconButton(
                  onPressed: () async {
                    var pdfValue = dataList
                        .where(
                          (element) =>
                              element['name'] ==
                              JobFinderCubit.get(context)
                                  .userModel!
                                  .userCV![index]['name'],
                        )
                        .toList();
                    JobFinderCubit.get(context)
                        .userModel!
                        .userCV!
                        .remove('${dataList[index]['name']}');
                    JobFinderCubit.get(context).updateUserDocFunction(
                      updateMap: {
                        'userCV': FieldValue.arrayRemove(pdfValue),
                      },
                    );
                    await FirebaseStorage.instance
                        .refFromURL(dataList[index]['link'])
                        .delete();
                    uploadedResume.clear();
                    print('==================== \n $uploadedResume');
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _myTextFormField({
    required TextEditingController textEditingController,
    required String hintTextVal,
    required Function onchangeValue,
    required IconData prefixIconData,
    TextInputType? textInputType,
  }) =>
      TextFormField(
        controller: textEditingController,
        onChanged: (value) => onchangeValue(value),
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintTextVal,
          isDense: true,
          prefixIcon: Icon(prefixIconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xff3366FF),
            ),
          ),
        ),
      );
}
