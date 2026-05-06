import 'package:flutter/material.dart';
import 'package:nucore_project/core/constants/font_strings.dart';
import 'package:nucore_project/core/utils/app_colors.dart';
import 'package:nucore_project/presentation/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.textSize,
    this.isLoading,
  });

  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? height;
  final double? textSize;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.appRed, AppColors.appOrange, AppColors.appOrange],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.appGrey.withAlpha(60),
            spreadRadius: 0.5,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading == true ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: isLoading == true
            ? SizedBox(
                height: height ?? 55 / 2.5,
                width: height ?? 55 / 2.5,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 3,
                ),
              )
            : AppText(
                text,
                color: AppColors.white,
                size: textSize ?? 15,
                family: lexend600,
              ),
      ),
    );
  }
}
