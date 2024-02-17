import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppliedScreen extends StatelessWidget {
  const AppliedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              appbarWithLogo(
                title: 'Applied job',
              ),
              DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F4F5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TabBar(
                    onTap: (int index) =>
                        cubit.changeActiveOrRejectedIndex(index),
                    splashBorderRadius: BorderRadius.circular(30),
                    indicatorPadding: const EdgeInsets.all(5),
                    tabs: const [
                      Tab(
                        text: 'Active',
                      ),
                      Tab(
                        text: 'Rejected',
                      ),
                    ],
                  ),
                ),
              ),
              ConditionalBuilder(
                condition: cubit.activeOrRejected == 'Active',
                fallback: (context) => currentState(context: context,
                  image: 'assets/images/access_state/DataIlustration(2).png',
                  title: 'No application were rejected',
                  subTitle:
                      'if there is an application that is rejected by the company it will appear here',
                ),
                builder: (context) =>
                    cubit.userModel!.appliedJobList!.isNotEmpty
                        ? _appliedBody(
                            cubitVal: cubit,
                            number: cubit.userModel!.appliedJobList!.length,
                            context: context)
                        : Container(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _appliedBody(
      {required JobFinderCubit cubitVal,
      required int number,
      required context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          screenSeparator(title: '$number jobs'),
          buildListViewSeparator(
              count: number,
              itemBuilderVal: (context, index) {
                var data = cubitVal.userModel!.appliedJobList![index]['data'];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    jobListTile(
                      context: context,
                      trailingIcon: Icons.cancel,
                      onIconButtonPress: () {
                        var value =
                            cubitVal.userModel!.appliedJobList![index]['data']
                                .where(
                                  (element) =>
                                      element['id'] ==
                                      cubitVal.userModel!.appliedJobList![index]
                                          ['id'],
                                )
                                .toList();
                        JobFinderCubit.get(context).updateUserDocFunction(
                          updateMap: {
                            'appliedJobList': FieldValue.arrayRemove(value),
                          },
                        );
                      },
                      jobTimeType: data['job_type'],
                      imageLink: data['image'],
                      jobPriceOrDate:
                          (data['created_at']).toString().substring(0, 10),
                      jobSubtitle: data['comp_name'],
                      jobTitle: data['name'],
                    ),
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Stepper(
                        type: StepperType.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        connectorThickness: 2,
                        elevation: 0,
                        currentStep: 0,
                        steps: const [
                          Step(
                            title: SizedBox(),
                            content: SizedBox(),
                            isActive: true,
                            label: Text(
                              'Bio data',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Step(
                            title: SizedBox(),
                            content: SizedBox(),
                            isActive: true,
                            label: Text(
                              'type of work',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Step(
                            title: SizedBox(),
                            content: SizedBox(),
                            isActive: true,
                            label: Text(
                              'portofolio',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
