import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSettingScreen extends StatelessWidget {
  const NotificationSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return Scaffold(
          appBar: appbarWithLogo(
                    title: 'Notification settings',
                  ),
          body: Column(
            children: [
              screenSeparator(title: 'Job Notification'),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.jobNotification.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => SwitchListTile(
                  dense: true,
                  title: Text(cubit.jobNotification[index]['name']),
                  value: cubit.jobNotification[index]['isOpened'],
                  onChanged: (value) =>
                      cubit.changeJobNotificationSetting(value, index),
                ),
              ),
              screenSeparator(title: 'Other Notification'),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.otherNotification.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => SwitchListTile(
                  dense: true,
                  title: Text(cubit.otherNotification[index]['name']),
                  value: cubit.otherNotification[index]['isOpened'],
                  onChanged: (value) =>
                      cubit.changeOtherJobNotificationSetting(value, index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
