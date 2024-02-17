import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

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
            title: 'Language',
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: buildListViewSeparator(
              count: cubit.languageList.length,
              itemBuilderVal: (context, index) => RadioListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(cubit.languageList[index]['name']),
                secondary: Image.network(
                  cubit.languageList[index]['src'],
                  width: 50,
                ),
                value: cubit.languageList[index]['name'],
                groupValue: cubit.selectedLanguageValue,
                onChanged: (value) =>
                    cubit.changeSelectedLanguageFuction(value!),
              ),
            ),
          ),
        );
      },
    );
  }
}
