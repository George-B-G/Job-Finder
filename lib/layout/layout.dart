import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:amit_job_finder/shared/network/remote/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        FirebaseMessageApi.setupInteractedMessage();
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavigationBarItem,
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeBottomNavBarIndex(index),
          ),
          body: SafeArea(child: cubit.screens[cubit.currentIndex]),
        );
      },
    );
  }
}
