import 'package:amit_job_finder/module/screens/save_and_apply/apply_for_job_screen.dart';
import 'package:amit_job_finder/module/screens/home/notification_screen.dart';
import 'package:amit_job_finder/module/screens/save_and_apply/job_discription_screen.dart';
import 'package:amit_job_finder/module/screens/search/search_screen.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:amit_job_finder/shared/network/remote/firebase_api.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List jobs = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        FirebaseMessageApi.setupInteractedMessage();
        FirebaseMessageApi.getNotificationOnForeground();
        return ConditionalBuilder(
          condition: cubit.apiData.isNotEmpty,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              top: screenDefaultSize * 4,
              left: screenDefaultSize * 1,
              right: screenDefaultSize * 1,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildCustomTitle(
                        title:
                            'Hi, ${cubit.userModel?.name ?? 'Loading...'} 👋',
                        subTitle: 'Create a better future for yourself here.',
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          onPressed: () => pushToPage(
                              context: context,
                              screenName: const NotificationScreen()),
                          icon: const Icon(Icons.notifications_outlined),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(
                    value: 3,
                  ),
                  customTextField(
                    hinttextValue: 'Search...',
                    onChangeFunction: (value) {},
                    prefixIconData: const Icon(Icons.search),
                    borderRadiusValue: BorderRadius.circular(35),
                    keyboardTextInputType: TextInputType.none,
                    onTapFunction: () => pushToPage(
                      context: context,
                      screenName: SearchScreen(),
                    ),
                  ),
                  verticalSpace(
                    value: 3,
                  ),
                  fastNavigatorLink(
                    context: context,
                    mainAxisAlignmentVal: MainAxisAlignment.spaceBetween,
                    text: 'Suggested Job',
                    styleVal: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                    buttonTitle: 'View all',
                    buttonStyleVal:
                        Theme.of(context).primaryTextTheme.labelMedium,
                    onPress: () {},
                  ),
                  verticalSpace(
                    value: 1,
                  ),
                  SizedBox(
                    height: 200,
                    child: buildListViewSeparator(
                      scrollDirectionValue: Axis.horizontal,
                      separatorWidget: horizontalSpace(value: 0.5),
                      scrollPhysics: const AlwaysScrollableScrollPhysics(),
                      count: cubit.apiData.length,
                      itemBuilderVal: (context, index) => buildJobCard(
                        context: context,
                        imageLink: cubit.apiData[index]['image'],
                        jobPriceOrDate: '\$${cubit.apiData[index]['salary']}',
                        jobSubtitle:
                            '${cubit.apiData[index]['comp_name']}, ${cubit.apiData[index]['job_type']}',
                        jobTitle: cubit.apiData[index]['name'],
                        jobTimeType: cubit.apiData[index]['job_time_type'],
                        onIconButtonPress: () {
                          jobs.insert(0, cubit.apiData[index]);
                          cubit.updateUserDocFunction(
                            updateMap: {
                              'savedJobList': jobs.toSet(),
                            },
                          );
                        },
                        mapData: cubit.apiData[index],
                      ),
                    ),
                  ),
                  verticalSpace(
                    value: 1,
                  ),
                  fastNavigatorLink(
                    context: context,
                    mainAxisAlignmentVal: MainAxisAlignment.spaceBetween,
                    text: 'Recent Job',
                    styleVal: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                    buttonTitle: 'View all',
                    buttonStyleVal:
                        Theme.of(context).primaryTextTheme.labelMedium,
                    onPress: () {},
                  ),
                  buildListViewSeparator(
                    count: cubit.apiData.length,
                    itemBuilderVal: (context, index) => jobListTile(
                      context: context,
                      imageLink: cubit.apiData[index]['image'],
                      jobPriceOrDate:
                          '\$${cubit.apiData[index]['salary']} /month',
                      jobSubtitle:
                          '${cubit.apiData[index]['comp_name']}, ${cubit.apiData[index]['job_type']}',
                      jobTitle: cubit.apiData[index]['name'],
                      jobTimeType: cubit.apiData[index]['job_time_type'],
                      onIconButtonPress: () {
                        jobs.insert(0, cubit.apiData[index]);
                        cubit.updateUserDocFunction(
                          updateMap: {
                            'savedJobList': jobs.toSet(),
                          },
                        );
                      },
                      onListTileTap: () => pushToPage(
                        context: context,
                        screenName: JobDiscriptionScreen(
                          data: cubit.apiData[index],
                        ),
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

  Widget buildJobCard({
    required context,
    required String imageLink,
    required String jobPriceOrDate,
    required String jobTimeType,
    required String jobSubtitle,
    required String jobTitle,
    required Function onIconButtonPress,
    required Map<String, dynamic> mapData,
  }) {
    var list = [];
    list.add(jobTimeType);
    return SizedBox(
      width: 320,
      child: Card(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                dense: true,
                title: Text(
                  jobTitle,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                subtitle: Text(
                  jobSubtitle,
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
                leading: Image.network(
                  imageLink,
                  width: 40,
                ),
                trailing: IconButton(
                  onPressed: () => onIconButtonPress(),
                  icon: const Icon(
                    Icons.bookmark_outline,
                  ),
                ),
              ),
              buildChoiceChip(
                isSelected: false,
                context: context,
                lst: list,
                lengthValue: list.length,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: jobPriceOrDate,
                          style: const TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const TextSpan(
                          text: ' /Month',
                          style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => pushToPage(
                      context: context,
                      screenName: ApplyForJobScreen(
                        data: mapData,
                      ),
                    ),
                    child: Text(
                      'Apply now',
                      style: Theme.of(context).primaryTextTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
