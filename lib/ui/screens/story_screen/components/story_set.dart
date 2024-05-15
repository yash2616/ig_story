import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ig_story/ui/screens/story_screen/components/story_progress_bar.dart';
import 'package:ig_story/ui/screens/story_screen/components/story_screen_navbar.dart';

import '../../../../data/model/user_model.dart';
import '../../../../utilities/media_query.dart';
import '../../../custom_widgets/custom_loader.dart';

class StorySet extends StatelessWidget {
  const StorySet({
    super.key,
    required this.pageController,
    required this.userData,
    required this.tapDown,
    required this.tapUp,
    required this.currentPage,
    required this.nextStory,
    required this.nextUser,
    required this.previousUser
  });

  final PageController pageController;
  final UserModel userData;
  final Function(PointerDownEvent) tapDown;
  final Function(PointerUpEvent) tapUp;
  final ValueNotifier<int> currentPage;
  final VoidCallback nextStory;
  final VoidCallback nextUser;
  final VoidCallback previousUser;

  void swipeControl(horizontalDragDetails, allowSwipe){

  }

  @override
  Widget build(BuildContext context) {
    bool allowSwipe = true;
    return Stack(
      children: [
        SizedBox(
          height: displayHeight(context),
          width: displayWidth(context),
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            itemCount: userData.stories.length,
            itemBuilder: (context, index){
              return CachedNetworkImage(
                imageUrl: userData.stories[index].mediaUrl,
                fit: BoxFit.fitWidth,
                placeholder: (context, _){
                  return Container(
                    height: displayHeight(context),
                    width: displayWidth(context),
                    color: Colors.grey.shade700,
                    child: const Center(
                      child: CustomLoader(),
                    ),
                  );
                },
              );
            },
          ),
        ),
        GestureDetector(
          onLongPressDown: (longPressDownDetails){
            // TODO: Story pause logic to be added
          },
          onLongPressUp: (){
            // TODO: Story un-pause logic to be added
          },
          onHorizontalDragUpdate: (details){
            if(!allowSwipe) return;

            if(details.delta.dx < -5){
              nextUser();
              allowSwipe = false;
              Future.delayed(const Duration(milliseconds: 1200), (){
                allowSwipe = true;
              });
            }
            else if(details.delta.dx > 5){
              previousUser();
              allowSwipe = false;
              Future.delayed(const Duration(milliseconds: 1200), (){
                allowSwipe = true;
              });
            }
          },
          child: Listener(
            onPointerDown: tapDown,
            onPointerUp: tapUp,
            child: Container(
              height: displayHeight(context),
              width: displayWidth(context),
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                child: Column(
                  children: [
                    const SizedBox(height: 8,),
                    ValueListenableBuilder(
                        valueListenable: currentPage,
                        builder: (context, _, __) {
                          return SizedBox(
                            height: 3,
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              scrollDirection: Axis.horizontal,
                              itemCount: userData.stories.length,
                              itemBuilder: (context, index){
                                return StoryProgressBar(
                                  index: index,
                                  currentIndex: currentPage.value,
                                  nextStory: nextStory,
                                  totalStories: userData.stories.length,
                                );
                              },
                            ),
                          );
                        }
                    ),
                    StoryScreenNavbar(
                      userName: userData.userName,
                      profilePic: userData.profilePic,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}