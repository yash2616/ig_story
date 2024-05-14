import 'package:flutter/material.dart';

import '../../../../utilities/app_asset.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top + 16,
        left: 24,
        right: 24,
      ),
      child: Row(
        children: [
          Image.asset(
            AppAssets.igText,
            height: 32,
          ),
          const Spacer(),
          const Icon(
            Icons.favorite_outline_rounded,
            size: 22,
          ),
          const SizedBox(width: 24,),
          const Icon(
            Icons.message_rounded,
            size: 22,
          ),

        ],
      ),
    );
  }
}