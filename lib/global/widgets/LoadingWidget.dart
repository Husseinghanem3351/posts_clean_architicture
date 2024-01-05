import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/global/themes/themes.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
      vertical: 30,
    ),
      child: Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child:CircularProgressIndicator(
            color: secondaryColor,
          ),
        ),
      ),
    );
  }
}
