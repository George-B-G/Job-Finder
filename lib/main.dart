import 'package:amit_job_finder/firebase_options.dart';
import 'package:amit_job_finder/layout/layout.dart';
import 'package:amit_job_finder/module/onboarding_screen.dart';
import 'package:amit_job_finder/shared/cubit/bloc_observer.dart';
import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:amit_job_finder/shared/components/size_config.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_cubit.dart';
import 'package:amit_job_finder/shared/cubit/job_finder_state.dart';
import 'package:amit_job_finder/shared/network/local/cache_helper.dart';
import 'package:amit_job_finder/shared/network/remote/dio_helper.dart';
import 'package:amit_job_finder/shared/network/remote/firebase_api.dart';
import 'package:amit_job_finder/shared/style/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessageApi.initNotification();
  await CacheHelper.init();
  await DioHelper.init();
  isRememberMe = CacheHelper.getBoolData(key: 'rememberMe');
  if (isRememberMe == true) {
    userId = CacheHelper.getStringData(key: 'uid');
    widgetScreens = const LayoutScreen();
  } else {
    widgetScreens = const OnBoardingScreen();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfiger().init(context); // to get the device size
    return BlocProvider(
      create: (context) {
        if (isRememberMe == true) {
          return JobFinderCubit()
            ..getApiData()
            ..getUserDataFunction()
            ..getChatApiData();
        } else {
          return JobFinderCubit();
        }
      },
      child: BlocConsumer<JobFinderCubit, JobFinderState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Job Finder',
            theme: buildMainTheme(),
            home: widgetScreens,
          );
        },
      ),
    );
  }
}
