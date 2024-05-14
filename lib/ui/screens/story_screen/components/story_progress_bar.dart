import 'package:flutter/material.dart';

import '../../../../utilities/media_query.dart';

class StoryProgressBar extends StatefulWidget {
  const StoryProgressBar({
    super.key, required this.index, required this.currentIndex, required this.nextStory, required this.totalStories,
  });

  final int index;
  final int currentIndex;
  final VoidCallback nextStory;
  final int totalStories;

  @override
  State<StoryProgressBar> createState() => _StoryProgressBarState();
}

class _StoryProgressBarState extends State<StoryProgressBar> with SingleTickerProviderStateMixin {

  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkForAnimation();
    });
  }

  @override
  void didUpdateWidget(covariant StoryProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkForAnimation();
    });
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  void checkForAnimation() {
    if(widget.index == widget.currentIndex){
      _animationController.forward(from: 0);
    }
    else{
      _animationController.value = 0;
      _animationController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 3,
          width: (displayWidth(context) - 10 - (widget.totalStories * 2)) / widget.totalStories,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: widget.currentIndex > widget.index ? Colors.grey : Colors.grey.shade300
          ),
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            if(_animationController.value == 1){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                _animationController.value = 0;
                widget.nextStory();
              });
            }
            return Container(
              height: 3,
              width: ((displayWidth(context) - 10 - (widget.totalStories * 2)) / widget.totalStories) * _animationController.value,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.grey
              ),
            );
          }
        ),
      ],
    );
  }
}