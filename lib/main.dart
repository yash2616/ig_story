import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ig_story/logic/cubit/story_cubit/story_cubit.dart';
import 'package:ig_story/logic/services/app_manager_service.dart';
import 'package:ig_story/ui/screens/splash_screen/splash_screen.dart';

import 'core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  setupServices();
  await dotenv.load(fileName: '.env');
  AppManager().setUserCollection(dotenv.env['USER_COLLECTION'] ?? '');
  AppManager().setStoryCollection(dotenv.env['STORY_COLLECTION'] ?? '');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<StoryCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'IG Story',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
