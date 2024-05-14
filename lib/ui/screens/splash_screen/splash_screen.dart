import 'package:flutter/material.dart';
import 'package:ig_story/ui/screens/home_screen/home_screen.dart';
import 'package:ig_story/utilities/app_asset.dart';
import 'package:ig_story/utilities/media_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return const HomeScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        color: Colors.white,
        alignment: Alignment.center,
        child: Image.asset(
          AppAssets.igLogo,
          height: 80,
        ),
      ),
    );
  }
}
