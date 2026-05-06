import 'package:flutter/material.dart';
import 'package:nucore_project/core/utils/app_colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(color: AppColors.appOrange),
      ),
    );
  }
}
