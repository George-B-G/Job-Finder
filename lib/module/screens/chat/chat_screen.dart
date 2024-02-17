import 'package:amit_job_finder/module/screens/chat/messages_screen.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  List<String> filter = ['unread', 'spam', 'archieve'];
  TextEditingController chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobFinderCubit, JobFinderState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = JobFinderCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.apiChatData.isNotEmpty,
          fallback: (context) => _currentState(
              image: 'assets/images/access_state/DataIlustration(1).png',
              title: 'You have not received any messages',
              subTitle:
                  'Once your application has reached the interview stage, you will get a message from the recruiter.'),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  appbarWithLogo(
                    title: 'Messages',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 3,
                        child: customTextField(
                          onTapFunction: () {},
                          onChangeFunction: (value) {},
                          textEditingController: chatController,
                          hinttextValue: 'Search massages',
                          prefixIconData: const Icon(Icons.search),
                          borderRadiusValue: BorderRadius.circular(35),
                        ),
                      ),
                      horizontalSpace(
                        value: 1,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          onPressed: () => _showModel(context: context),
                          icon: const ImageIcon(NetworkImage(
                              'https://cdn-icons-png.flaticon.com/128/4502/4502383.png')),
                        ),
                      )
                    ],
                  ),
                  verticalSpace(
                    value: 2,
                  ),
                  buildListViewSeparator(
                    count: cubit.apiChatData.length,
                    itemBuilderVal: (context, index) => ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            data: cubit.apiChatData[index],
                          ),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${cubit.apiChatData[index]['sender_user']}'),
                          Text(
                            cubit.apiChatData[index]['created_at']
                                .toString()
                                .substring(5, 10),
                            style:
                                Theme.of(context).primaryTextTheme.labelMedium,
                          ),
                        ],
                      ),
                      subtitle: Text(cubit.apiChatData[index]['massage']),
                      leading: Image.network(
                        fit: BoxFit.cover,
                        'https://th.bing.com/th/id/OIP.IGgU8LQcU3JnHZ_70Nt5GwHaHa?w=129&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
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

  _showModel({
    required context,
  }) {
    List<String> buttonsName = [
      'unread',
      'spam',
      'archieve',
    ];
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        showDragHandle: true,
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 5, bottom: 20),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildListViewSeparator(
                    count: buttonsName.length,
                    separatorWidget: verticalSpace(value: 0.5),
                    itemBuilderVal: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListTile(
                        dense: true,
                        title: Text(buttonsName[index]),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _currentState({
    required String image,
    required String title,
    required String subTitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 130,
          ),
          buildCustomTitle(
            crossAxisAlignmentVal: CrossAxisAlignment.center,
            textAlignVal: TextAlign.center,
            title: title,
            subTitle: subTitle,
          ),
        ],
      ),
    );
  }
}
