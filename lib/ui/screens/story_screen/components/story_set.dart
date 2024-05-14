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
    required this.nextStory
  });

  final PageController pageController;
  final UserModel userData;
  final Function(PointerDownEvent) tapDown;
  final Function(PointerUpEvent) tapUp;
  final ValueNotifier<int> currentPage;
  final VoidCallback nextStory;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: displayHeight(context),
          width: displayWidth(context),
          child: PageView.builder(
            controller: pageController,
            itemCount: userData.stories.length,
            itemBuilder: (context, index){
              return CachedNetworkImage(
                imageUrl: userData.stories[index].mediaUrl,
                fit: BoxFit.cover,
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