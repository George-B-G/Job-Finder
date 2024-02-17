import 'package:amit_job_finder/module/screens/save_and_apply/job_discription_screen.dart';
import 'package:amit_job_finder/module/screens/search/search_result_screen.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  List recentSearch = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: customTextField(
              hinttextValue: 'Type something...',
              textEditingController: searchController,
              prefixIconData: const Icon(Icons.search),
              keyboardTextInputAction: TextInputAction.search,
              onTapFunction: () {},
              onChangeFunction: (String value) {
                cubit.getSearchData(
                  nameValue: value,
                  locationValue: '',
                  salaryValue: '',
                );
                isSearch = true;
              },
            ),
          ),
          body: ConditionalBuilder(
            condition: isSearch,
            fallback: (context) => isSearch
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _searchedHistroy(cuibVal: cubit, recentSearch: recentSearch),
            builder: (context) => Expanded(
              child: buildListViewSeparator(
                scrollPhysics: const BouncingScrollPhysics(),
                count: cubit.searchData.length,
                itemBuilderVal: (context, index) => ListTile(
                    title: Text(cubit.searchData[index]['name']),
                    onTap: () {
                      recentSearch.add(cubit.searchData[index]);
                      pushToPage(
                        context: context,
                        screenName: SearchResultScreen(data: recentSearch),
                      );
                      _searchedHistroy(
                          cuibVal: cubit, recentSearch: recentSearch);
                    }),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _searchedHistroy(
          {required JobFinderCubit cuibVal, required List recentSearch}) =>
      SingleChildScrollView(
        child: Column(
          children: [
            recentSearch.isNotEmpty
                ? screenSeparator(title: 'Recent searchs')
                : Container(),
            recentSearch.isNotEmpty
                ? buildListViewSeparator(
                    count: recentSearch.length,
                    itemBuilderVal: (context, index) => ListTile(
                      title: Text(recentSearch[index]['name']),
                      leading: const Icon(Icons.history),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {},
                      ),
                      onTap: () {},
                    ),
                  )
                : Container(),
            screenSeparator(title: 'Popular searchs'),
            buildListViewSeparator(
              count: cuibVal.apiData.length,
              itemBuilderVal: (context, index) => ListTile(
                title: Text(cuibVal.apiData[index]['name']),
                leading: const Icon(Icons.search),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_circle_right_outlined),
                  onPressed: () {},
                ),
                onTap: () => pushToPage(
                  context: context,
                  screenName: JobDiscriptionScreen(
                    data: cuibVal.apiData[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
