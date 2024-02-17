import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(notificationList);
    return Scaffold(
      appBar: appbarWithLogo(
        title: 'Notification',
      ),
      body: ConditionalBuilder(
        condition: notificationList.isNotEmpty,
        fallback: (context) => _currentState(
          image: 'assets/images/access_state/Notification Ilustration.png',
          title: 'No new notification yet',
          subTitle:
              'You will receive a notification if there is something on your account',
        ),
        builder: (context) => _notifiactionBody(lst: notificationList.toList()),
      ),
    );
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
          verticalSpace(value: 3),
          buildCustomTitle(
            crossAxisAlignmentVal: CrossAxisAlignment.center,
            textAlignVal: TextAlign.center,
            title: title,
            subTitle: subTitle,
          ),
          verticalSpace(value: 5),
        ],
      ),
    );
  }

  Widget _notifiactionBody({required List lst}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          screenSeparator(title: 'New'),
          buildListViewSeparator(
            isReversed: true,
            count: lst.length,
            itemBuilderVal: (context, index) => ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(lst[index]['notificationTitle'] ?? ''),
                  Text(lst[index]['time'].toString().substring(5, 16)),
                ],
              ),
              subtitle: Text(lst[index]['notificationBody'] ?? ''),
              leading: Image.network(
                'https://cdn-icons-png.flaticon.com/128/11463/11463090.png',
                width: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
