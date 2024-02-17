import 'package:amit_job_finder/shared/components/components.dart';
import 'package:flutter/material.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({
    super.key,
    required this.appBarTitle,
    required this.firstTitle,
    required this.firstContent,
    required this.secondTitle,
    required this.secondContent,
  });
  final String appBarTitle;
  final String firstTitle;
  final String firstContent;
  final String secondTitle;
  final String secondContent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstTitle,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              verticalSpace(
                value: 1.5,
              ),
              Text(
                firstContent,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              verticalSpace(
                value: 2,
              ),
              Text(
                secondTitle,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              verticalSpace(
                value: 1.5,
              ),
              Text(
                secondContent,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
