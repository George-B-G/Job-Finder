import 'package:amit_job_finder/module/screens/save_and_apply/apply_for_job_screen.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.userModel!.savedJobList!.isNotEmpty,
          fallback: (context) => Center(
            child: currentState(
              context: context,
              image: 'assets/images/access_state/Icon.png',
              title: 'Nothing has been saved Yet',
              subTitle: 'Press the star icon on the job you want to save',
            ),
          ),
          builder: (context) => _savedBody(
            context: context,
            savedJobNum: cubit.userModel!.savedJobList!.length,
            cubitVal: cubit,
          ),
        );
      },
    );
  }

  Widget _savedBody({
    required context,
    required int savedJobNum,
    required JobFinderCubit cubitVal,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          appbarWithLogo(
            title: 'Saved',
          ),
          screenSeparator(
              title: '$savedJobNum job saved', textAlignVal: TextAlign.center),
          buildListViewSeparator(
            count: savedJobNum,
            itemBuilderVal: (context, index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cubitVal.userModel!.savedJobList![index]['name']),
                      IconButton(
                          onPressed: () => _showModel(
                                context: context,
                                dataMap:
                                    cubitVal.userModel!.savedJobList![index],
                                cubitVal: cubitVal.userModel!.savedJobList!
                                    .where(
                                      (element) =>
                                          element['id'] ==
                                          cubitVal.userModel!
                                              .savedJobList![index]['id'],
                                    )
                                    .toList(),
                              ),
                          icon: const Icon(Icons.more_horiz_outlined)),
                    ],
                  ),
                  subtitle: Text(
                      '${cubitVal.userModel!.savedJobList![index]['comp_name']}, ${cubitVal.userModel!.savedJobList![index]['job_type']}'),
                  leading: Image.network(
                    cubitVal.userModel!.savedJobList![index]['image'],
                    width: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((cubitVal.userModel!.savedJobList![index]
                              ['created_at'])
                          .toString()
                          .substring(0, 10)),
                      const Text('be an early  applicant'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showModel({
    required context,
    required Map<String, dynamic> dataMap,
    required List cubitVal,
  }) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      showDragHandle: true,
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildButtonOption(
              name: 'Apply job',
              iconImage:
                  'https://cdn-icons-png.flaticon.com/128/10490/10490209.png',
              ontap: () => pushToPage(
                context: context,
                screenName: ApplyForJobScreen(
                  data: dataMap,
                ),
              ),
            ),
            _buildButtonOption(
              name: 'Share via',
              iconImage:
                  'https://cdn-icons-png.flaticon.com/128/6423/6423903.png',
              ontap: () {},
            ),
            _buildButtonOption(
              name: 'Cancel save',
              iconImage:
                  'https://cdn-icons-png.flaticon.com/128/8924/8924220.png',
              ontap: () => JobFinderCubit.get(context).updateUserDocFunction(
                updateMap: {
                  'savedJobList': FieldValue.arrayRemove(cubitVal),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonOption({
    required String name,
    required String iconImage,
    required Function ontap,
  }) =>
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey),
        ),
        child: ListTile(
          dense: true,
          title: Text(name),
          trailing: const Icon(Icons.arrow_forward_ios),
          leading: ImageIcon(NetworkImage(iconImage)),
          onTap: () => ontap(),
        ),
      );
}
