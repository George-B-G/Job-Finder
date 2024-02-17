import 'package:amit_job_finder/module/auth/login_screen.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // showing onboarding image, title and subtitle.
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PageView(
              controller: pageController,
              children: [
                buildPageViewItem(
                  imagePath: 'assets/images/onboarding_screen.png',
                  startTitleSpan: 'Find a job, and ',
                  midTitleSpan: ' start building ',
                  endTitleSpan: 'your career from now on.',
                  subTitle:
                      'Explore over 25,924 available job roles and upgrade your operator now.',
                ),
                buildPageViewItem(
                  imagePath: 'assets/images/onboarding_screen_two.png',
                  startTitleSpan: 'Hundreds of jobs are waiting for you to ',
                  midTitleSpan: 'join together',
                  subTitle:
                      'Immediately join us and start applying for the job you are interested in.',
                ),
                buildPageViewItem(
                  imagePath: 'assets/images/onboarding_screen_three.png',
                  startTitleSpan: 'Get the best ',
                  midTitleSpan: 'choice for the job ',
                  endTitleSpan: 'you\'ve always dreamed of',
                  subTitle:
                      'The better the skills you have, the greater the good job opportunities for you.',
                ),
              ],
            ),
          ),

          // postion for the logo and skip button.
          Positioned(
            top: screenDefaultSize * 3.5,
            left: screenDefaultSize * 1,
            right: screenDefaultSize * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  height: 25,
                  image: AssetImage(
                    mainAppLogo,
                  ),
                ),
                Visibility(
                  visible: pageController.hasClients
                      ? (pageController.page == 2 ? false : true)
                      : true,
                  child: InkWell(
                    child: Text(
                      'Skip',
                      style: Theme.of(context).primaryTextTheme.labelMedium,
                    ),
                    onTap: () {
                      pushReplacementToPage(
                        context: context,
                        screenName: LoginScreen(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // dots indicator
          Positioned(
            left: 0,
            right: 0,
            bottom: screenDefaultSize * 10,
            child: DotsIndicator(
              dotsCount: 3,
              axis: Axis.horizontal,
              decorator: const DotsDecorator(
                activeColor: Color(0xff3366FF),
                spacing: EdgeInsets.all(3),
                activeSize: Size.square(13),
              ),
              position:
                  pageController.hasClients ? pageController.page!.toInt() : 0,
            ),
          ),

          // containing (next and get started) button.
          Positioned(
            left: screenDefaultSize * 1,
            right: screenDefaultSize * 1,
            bottom: screenDefaultSize * 3,
            child: ElevatedButton(
              onPressed: () {
                if (pageController.page! < 2) {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                } else {
                  pushReplacementToPage(
                    context: context,
                    screenName: LoginScreen(),
                  );
                }
              },
              child: Text(
                style: Theme.of(context).primaryTextTheme.labelLarge,
                pageController.hasClients
                    ? (pageController.page! == 2 ? 'Get Started' : 'next')
                    : 'next',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
