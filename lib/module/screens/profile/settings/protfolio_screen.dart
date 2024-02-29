import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProtofolioScreen extends StatelessWidget {
  const ProtofolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return Scaffold(
          appBar:appbarWithLogo(
                    title: 'Protofolio',
                  ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add portfolio here',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  verticalSpace(
                    value: 1,
                  ),
                  _buildUploadingFile(
                    context: context,
                    cubitVal: cubit,
                  ),
                  verticalSpace(
                    value: 1,
                  ),
                  ConditionalBuilder(
                    condition: cubit.userModel!.userCV!.isNotEmpty,
                    fallback: (context) => const SizedBox(),
                    builder: (context) => buildListViewSeparator(
                      count: cubit.userModel!.userCV!.length,
                      separatorWidget: verticalSpace(
                        value: 1,
                      ),
                      itemBuilderVal: (context, index) => _buildResumeItem(
                        context: context,
                        pdfName: cubit.userModel!.userCV![index]['name'],
                        pdfValue: cubit.userModel!.userCV!
                            .where(
                              (element) =>
                                  element['name'] ==
                                  cubit.userModel!.userCV![index]['name'],
                            )
                            .toList(),
                        pdfLink: cubit.userModel!.userCV![index]['link'],
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
          height: 220,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffECF2FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.upload_file_rounded,
                  size: 35,
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
    required String pdfName,
    required List pdfValue,
    required String pdfLink,
    required context,
  }) =>
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(pdfName),
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
                  JobFinderCubit.get(context)
                      .userModel!
                      .userCV!
                      .remove(pdfValue);
                  JobFinderCubit.get(context).updateUserDocFunction(
                    updateMap: {
                      'userCV': FieldValue.arrayRemove(pdfValue),
                    },
                  );
                  await FirebaseStorage.instance.refFromURL(pdfLink).delete();
                  uploadedResume.clear();
                  // print('==================== \n $uploadedResume');
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      );
}
