import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../custom_widgets/custom_close_button.dart';

class StoryScreenNavbar extends StatelessWidget {
  const StoryScreenNavbar({
    super.key, required this.userName, required this.profilePic,
  });

  final String userName;
  final String profilePic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: profilePic,
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8,),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const CustomCloseButton(),
        ],
      ),
    );
  }
}