import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.7),
      ),
    );
  }
}