import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ig_story/data/model/user_model.dart';
import 'package:ig_story/ui/screens/story_screen/story_screen.dart';

import '../../../../utilities/app_asset.dart';
import '../../../../utilities/app_colors.dart';

class StoryAvatar extends StatelessWidget {
  const StoryAvatar({
    super.key, required this.myAvatar, this.userData,
  });

  final bool myAvatar;
  final UserModel? userData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              if(myAvatar) return;

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return StoryScreen(userData: userData!,);
              }));
            },
            child: Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: myAvatar ? null : const LinearGradient(
                    colors: AppColors.igGradient,
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  )
              ),
              child: Container(
                height: 76,
                width: 76,
                padding: EdgeInsets.all(myAvatar ? 0 : 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: myAvatar ? Image.asset(
                    AppAssets.myPic,
                    fit: BoxFit.cover,
                  ) : CachedNetworkImage(
                    imageUrl: userData!.profilePic,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4,),
          Text(
            myAvatar ? 'Your story' : userData!.userName,
            style: TextStyle(
              fontSize: 12,
              fontWeight: myAvatar ? FontWeight.w300 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}