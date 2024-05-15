import 'package:flutter/material.dart';
import 'package:ig_story/utilities/app_keys.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: Container(
        key: const Key(AppKeys.storyCloseButtonKey),
        height: 40,
        width: 40,
        color: Colors.transparent,
        child: const Icon(
          Icons.close,
          color: Colors.black,
          size: 24,
        ),
      ),
    );
  }
}