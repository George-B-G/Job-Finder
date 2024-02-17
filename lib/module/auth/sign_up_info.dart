import 'package:amit_job_finder/layout/layout.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/current_user_state.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeOfWorkScreen extends StatelessWidget {
  TypeOfWorkScreen({super.key});

  final List<String> jobList = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        var cubit = JobFinderCubit.get(context);
        if (state is SelectedJobTypeCardState) {
          for (var element in cubit.jobCardList) {
            element['selected'] == true
                ? jobList.add(element['name'])
                : (element['selected'] == false
                    ? jobList.remove(element['name'])
                    : jobList.add(element['name']));
          }
        } else if (state is UpdateUserDocSuccessState) {
          pushReplacementToPage(
            context: context,
            screenName: PreferedLocationScreen(),
          );
          jobList.clear();
        }
      },
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                verticalSpace(value: 3),
                buildCustomTitle(
                  title: 'What type of work are you interested in?',
                  subTitle:
                      'Tell us what you\'re interested in so we can customise the app for your needs.',
                ),
                verticalSpace(value: 1.5),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 7,
                  ),
                  itemCount: cubit.jobCardList.length,
                  itemBuilder: (context, index) => _customWorkCard(
                    context: context,
                    cardName: cubit.jobCardList[index]['name'],
                    iconData: cubit.jobCardList[index]['icon'],
                    isSelected: cubit.jobCardList[index]['selected'],
                    onTapFunction: () =>
                        cubit.changeSelectedJobType(index: index),
                  ),
                ),
                verticalSpace(value: 3),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'Next',
                      style: Theme.of(context).primaryTextTheme.labelLarge,
                    ),
                    onPressed: () {
                      cubit.updateUserDocFunction(updateMap: {
                        'type_of_work': jobList.toSet(),
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _customWorkCard({
  required BuildContext context,
  required String cardName,
  required IconData iconData,
  required bool isSelected,
  required Function onTapFunction,
}) =>
    GestureDetector(
      onTap: () => onTapFunction(),
      child: Container(
        // width: 156,
        // height: 125,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected == false
                ? const Color(0xffd1d1d5db)
                : const Color(0xFF2E5BE3),
          ),
          color: isSelected == false
              ? const Color(0xffFAFAFA)
              : const Color(0xffD6E4FF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected == false
                      ? const Color(0xffd1d1d5db)
                      : const Color(0xFF2E5BE3),
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  iconData,
                  color: isSelected == false
                      ? Colors.black
                      : const Color(0xFF2E5BE3),
                ),
              ),
            ),
            Text(
              cardName,
              style: Theme.of(context).primaryTextTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
}

class PreferedLocationScreen extends StatelessWidget {
  PreferedLocationScreen({super.key});

  final List<String> jobLocation = [];
  String? homeOrRemote;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        var cubit = JobFinderCubit.get(context);
        if (state is SelectedJobCountryLocationState) {
          for (var element in cubit.country) {
            element['selected'] == true
                ? jobLocation.add(element['name'])
                : (element['selected'] == false
                    ? jobLocation.remove(element['name'])
                    : jobLocation.add(element['name']));
          }
        } else if (state is UpdateUserDocSuccessState) {
          JobFinderCubit.get(context).getUserDataFunction();
          pushReplacementToPage(
            context: context,
            screenName: CurrentUserState(
              key: key,
              buttonTitle: 'Get Started',
              image: 'assets/images/access_state/SuccessAccountIlustration.png',
              title: 'Your account has been set up!',
              subTitle:
                  'We have customized feeds according to your preferences',
              goToScreen: const LayoutScreen(),
            ),
          );
          jobLocation.clear();
        }
      },
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(value: 3),
                buildCustomTitle(
                  title: 'Where are you prefefred Location?',
                  subTitle:
                      'Let us know, where is the work location you want at this time, so we can adjust it.',
                ),
                verticalSpace(value: 2),
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
                      onTap: (int index) => index == 0
                          ? homeOrRemote = 'Work from home'
                          : homeOrRemote = 'Remote work',
                      splashBorderRadius: BorderRadius.circular(30),
                      indicatorPadding: const EdgeInsets.all(5),
                      tabs: const [
                        Tab(
                          text: 'Work from home',
                        ),
                        Tab(
                          text: 'Remote work',
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(value: 1.5),
                const Text(
                  'Select the country you want for your job',
                  style: TextStyle(color: Color(0xff737379)),
                ),
                verticalSpace(value: 1.5),
                Wrap(
                  spacing: 5.0,
                  children: List<Widget>.generate(
                    cubit.country.length,
                    (int index) {
                      return ChoiceChip(
                        showCheckmark: false,
                        selectedColor: const Color(0xffD6E4FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: cubit.country[index]['selected']
                                ? const Color(0xFF2E5BE3)
                                : const Color(0xffd1d1d5db),
                          ),
                        ),
                        label: Text(cubit.country[index]['name']),
                        avatar: Image.asset(
                          cubit.country[index]['image'],
                        ),
                        selected: cubit.country[index]['selected'],
                        onSelected: (bool selected) =>
                            cubit.changeSelectedCountryLocation(
                          isSelectedCountry: selected,
                          index: index,
                        ),
                      );
                    },
                  ).toList(),
                ),
                verticalSpace(value: 3),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'Next',
                      style: Theme.of(context).primaryTextTheme.labelLarge,
                    ),
                    onPressed: () {
                      cubit.updateUserDocFunction(updateMap: {
                        'preferred_location': jobLocation.toSet(),
                        'workFromHomeOrRemote': homeOrRemote == null
                            ? 'work from home'
                            : homeOrRemote!,
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


}
