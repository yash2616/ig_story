import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ig_story/data/model/user_model.dart';
import 'package:ig_story/utilities/media_query.dart';

import '../../../logic/services/gesture_interaction_service.dart';
import '../../custom_widgets/custom_loader.dart';
import 'components/story_progress_bar.dart';
import 'components/story_screen_navbar.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key, required this.userData});

  final UserModel userData;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {

  final GestureInteractionService _gestureInteractionService = GestureInteractionService();

  final ValueNotifier _currentPage = ValueNotifier(0);

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  void tapDown(pointerDown){
    _gestureInteractionService.setTapDownOffset(pointerDown.position);
    _gestureInteractionService.setTapDownTime(pointerDown.timeStamp.inMilliseconds);
  }

  void tapUp(pointerUp){
    _gestureInteractionService.setTapUpTime(pointerUp.timeStamp.inMilliseconds);
    _gestureInteractionService.setTapUpOffset(pointerUp.position);
    bool tapped = _gestureInteractionService.isTap();
    if(tapped){
      if(_gestureInteractionService.isLeftTap(displayWidth(context))){
        previousStory();
      }
      else{
        nextStory();
      }
    }
    _gestureInteractionService.clearData();
  }

  void previousStory() {
    if(_currentPage.value > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 350), curve: Curves.linearToEaseOut);
      _currentPage.value -= 1;
    }
  }

  void nextStory() {
    if(_currentPage.value < 2) {
      _pageController.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.linearToEaseOut);
      _currentPage.value += 1;
    }
    else{
      nextUser();
    }
  }

  void nextUser() {
    _pageController.animateToPage(0, duration: const Duration(milliseconds: 350), curve: Curves.linearToEaseOut);
    _currentPage.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: displayHeight(context),
            width: displayWidth(context),
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.userData.stories.length,
              itemBuilder: (context, index){
                return CachedNetworkImage(
                  imageUrl: widget.userData.stories[index].mediaUrl,
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
              // print('Long press down');
            },
            onLongPressUp: (){
              // print('Long press up');
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
                        valueListenable: _currentPage,
                        builder: (context, _, __) {
                          return SizedBox(
                            height: 3,
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.userData.stories.length,
                              itemBuilder: (context, index){
                                return StoryProgressBar(
                                  index: index,
                                  currentIndex: _currentPage.value,
                                  nextStory: nextStory,
                                  totalStories: widget.userData.stories.length,
                                );
                              },
                            ),
                          );
                        }
                      ),
                      StoryScreenNavbar(
                        userName: widget.userData.userName,
                        profilePic: widget.userData.profilePic,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
