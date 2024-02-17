import 'package:amit_job_finder/module/screens/save_and_apply/job_discription_screen.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({super.key, required this.data});

  List jobs = [];
  final List data;
  TextEditingController searchController = TextEditingController();
  TextEditingController jobtitleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: customTextField(
              hinttextValue: 'Type something...',
              textEditingController: searchController,
              onChangeFunction: (value) => cubit.getSearchData(
                locationValue: '',
                salaryValue: '',
                nameValue: value,
              ),
              onTapFunction: () {},
              keyboardTextInputAction: TextInputAction.search,
              prefixIconData: const Icon(Icons.search),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: () {
                      _showModel(
                        context: context,
                        jobTitleController: jobtitleController,
                        locationController: locationController,
                        salaryController: salaryController,
                        cuibtVal: cubit,
                      );
                    },
                    icon: const ImageIcon(NetworkImage(
                        'https://cdn-icons-png.flaticon.com/128/4502/4502383.png')),
                  ),
                ),
                screenSeparator(title: 'Feature'),
                buildListViewSeparator(
                  count: data.length,
                  itemBuilderVal: (context, index) => jobListTile(
                    context: context,
                    imageLink: data[index]['image'],
                    jobPriceOrDate: '\$${data[index]['salary']} /month',
                    jobSubtitle:
                        '${data[index]['comp_name']}, ${data[index]['job_type']}',
                    jobTitle: data[index]['name'],
                    jobTimeType: data[index]['job_time_type'],
                    onIconButtonPress: () {
                      jobs.insert(0, data[index]);
                      cubit.updateUserDocFunction(
                        updateMap: {
                          'savedJobList': jobs.toSet(),
                        },
                      );
                    },
                    onListTileTap: () => pushToPage(
                      context: context,
                      screenName: JobDiscriptionScreen(
                        data: data[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showModel({
    required context,
    required TextEditingController jobTitleController,
    required TextEditingController locationController,
    required TextEditingController salaryController,
    required JobFinderCubit cuibtVal,
  }) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        showDragHandle: true,
        scrollControlDisabledMaxHeightRatio: 25,
        builder: (context) => Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Job title',
                  ),
                  customTextField(
                    hinttextValue: 'job title',
                    textEditingController: jobTitleController,
                    onChangeFunction: (value) =>
                        jobTitleController.text = value,
                    onTapFunction: () {},
                  ),
                  const Text(
                    'Location',
                  ),
                  customTextField(
                    hinttextValue: 'location',
                    textEditingController: jobTitleController,
                    onChangeFunction: (value) =>
                        jobTitleController.text = value,
                    onTapFunction: () {},
                  ),
                  const Text(
                    'Salary',
                  ),
                  customTextField(
                    hinttextValue: 'salary',
                    textEditingController: jobTitleController,
                    onChangeFunction: (value) =>
                        jobTitleController.text = value,
                    onTapFunction: () {},
                  ),
                  const Text(
                    'Job Type',
                  ),
                  _buildChoiceChip(
                    context: context,
                    lengthValue: cuibtVal.filterChoiceChip.length,
                    cubitVal: cuibtVal,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            JobFinderCubit.get(context).getSearchData(
                                nameValue: jobTitleController.text,
                                locationValue: locationController.text,
                                salaryValue: salaryController.text);
                          },
                          child: const Text(
                            'Show result',
                            style: TextStyle(color: Colors.white),
                          ))),
                ],
              ),
            ));
  }

  Widget _buildChoiceChip({
    required context,
    required int lengthValue,
    required JobFinderCubit cubitVal,
  }) =>
      Wrap(
        spacing: 5.0,
        children: List<Widget>.generate(
          lengthValue,
          (int index) {
            return ChoiceChip(
              padding: const EdgeInsets.all(0),
              showCheckmark: false,
              selectedColor: const Color(0xffD6E4FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              label: Text(
                cubitVal.filterChoiceChip[index]['name'],
                style: Theme.of(context).primaryTextTheme.labelMedium,
              ),
              onSelected: (value) => cubitVal.changeChoiceChipFilter(
                isSelected: value,
                index: index,
              ),
              selected: cubitVal.filterChoiceChip[index]['selected'],
            );
          },
        ).toList(),
      );
}
