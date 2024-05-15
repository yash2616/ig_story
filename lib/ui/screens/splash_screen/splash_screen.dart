import 'package:flutter/material.dart';
import 'package:ig_story/core/service_locator.dart';
import 'package:ig_story/logic/services/db_service.dart';
import 'package:ig_story/ui/screens/home_screen/home_screen.dart';
import 'package:ig_story/utilities/app_asset.dart';
import 'package:ig_story/utilities/media_query.dart';

import '../../../data/model/user_model.dart';
import '../../../logic/cubit/story_cubit/story_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool exit = false;

  @override
  void initState() {
    super.initState();
    preLoadStories();
  }

  void preLoadStories() async {
    // Navigate to home screen after 3 seconds of wait time
    Future.delayed(const Duration(seconds: 3), (){
      if(exit || !mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return const HomeScreen();
      }));
    });

    final List<UserModel> cache = await loadCache();

    if(cache.isEmpty){
      serviceLocator<StoryCubit>().fetchStories().then((value){
        autoNavigate();
      });
    }
    else{
      serviceLocator<StoryCubit>().refreshStories(cachedData: cache);
      autoNavigate();
    }
  }

  Future<List<UserModel>> loadCache() async {
    final List<UserModel> cache = await DatabaseService().getAllStories();
    return cache;
  }

  void autoNavigate() {
    exit = true;
    if(!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const HomeScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.igLogo,
              height: 80,
            ),
            const SizedBox(height: 16,),
            const Text(
              'by Yash Srivastava',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
