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
        fallback: (context) => currentState(
          context: context,
          image: 'assets/images/access_state/Notification Ilustration.png',
          title: 'No new notification yet',
          subTitle:
              'You will receive a notification if there is something on your account',
        ),
        builder: (context) => _notifiactionBody(lst: notificationList.toList()),
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
