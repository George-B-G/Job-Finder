import 'package:amit_job_finder/shared/components/components.dart';
import 'package:flutter/material.dart';

class CurrentUserState extends StatelessWidget {
  final String image, title, subTitle, buttonTitle;
  final Widget goToScreen;
  const CurrentUserState({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.buttonTitle,
    required this.goToScreen,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            
           ElevatedButton(
                    onPressed: () 
                    =>  pushReplacementToPage(
                          context: context, screenName: goToScreen)
                    ,
                    child: Text(
                      buttonTitle,
                      style: Theme.of(context).primaryTextTheme.labelLarge,
                    ),
                  )
                ,
          ],
        ),
      ),
    );
  }
}
