import 'package:amit_job_finder/module/screens/save_and_apply/apply_for_job_screen.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobDiscriptionScreen extends StatelessWidget {
  JobDiscriptionScreen({super.key, required this.data});

  final Map<String, dynamic> data;
  List jobs = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        var list = [];
        list.add(data['job_type']);
        list.add(data['job_time_type']);
        return Scaffold(
          appBar: appbarWithLogo(
            title: 'Messages',
            isHavingButton: true,
            lst: [
              IconButton(
                onPressed: () {
                  jobs.insert(0, data);
                  cubit.updateUserDocFunction(
                    updateMap: {
                      'savedJobList': jobs.toSet(),
                    },
                  );
                },
                icon: const Icon(Icons.bookmark_border_outlined),
              ),
            ],
          ),
          body: Stack(
            children: [
              Positioned(
                left: screenDefaultSize * 1,
                right: screenDefaultSize * 1,
                bottom: screenDefaultSize * 3,
                child: ElevatedButton(
                  onPressed: () => pushToPage(
                    context: context,
                    screenName: ApplyForJobScreen(data: data),
                  ),
                  child: Text(
                    'Apply now',
                    style: Theme.of(context).primaryTextTheme.labelLarge,
                  ),
                ),
              ),
              Positioned(
                top: screenDefaultSize * 5,
                left: screenDefaultSize * 1,
                right: screenDefaultSize * 1,
                child: Column(
                  children: [
                    Image.network(
                      data['image'],
                      height: 50,
                    ),
                    verticalSpace(
                      value: 1,
                    ),
                    Text(
                      data['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${data['comp_name']}, ${data['job_type']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    buildChoiceChip(
                      isSelected: false,
                      context: context,
                      lengthValue: list.length,
                      lst: list,
                    ),
                    DefaultTabController(
                      length: 3,
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
                              cubit.changeJobDetailTabBarIndex(index),
                          splashBorderRadius: BorderRadius.circular(30),
                          indicatorPadding: const EdgeInsets.all(5),
                          tabs: const [
                            Tab(
                              text: 'Desicription',
                            ),
                            Tab(
                              text: 'Company',
                            ),
                            Tab(
                              text: 'People',
                            ),
                          ],
                        ),
                      ),
                    ),
                    _contentBody(cubitVal: cubit, dataVal: data),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _contentBody({
    required JobFinderCubit cubitVal,
    required dataVal,
  }) {
    if (cubitVal.jobDetail == 'Desicription') {
      return SizedBox(
        height: screenDefaultSize * 30,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          children: [
            const Text(
              'Job Desicription',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(dataVal['job_description'],
                style: TextStyle(color: Colors.grey.shade600)),
            verticalSpace(
              value: 1,
            ),
            const Text(
              'Skills Required',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(dataVal['job_skill'],
                style: TextStyle(color: Colors.grey.shade600)),
            verticalSpace(
              value: 1,
            ),
            const Text(
              'Location',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(dataVal['location'],
                style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      );
    } else if (cubitVal.jobDetail == 'Company') {
      return SizedBox(
        height: screenDefaultSize * 30,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          children: [
            const Text(
              'Contact us',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        Text(data['comp_email']),
                      ],
                    ),
                  ),
                ),
                horizontalSpace(
                  value: 1,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Website',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        Text(data['comp_website']),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(
              value: 1,
            ),
            const Text(
              'About Company',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(dataVal['about_comp'],
                style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: screenDefaultSize * 30,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          children: const [],
        ),
      );
    }
  }
}
