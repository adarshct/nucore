import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nucore_project/core/constants/font_strings.dart';
import 'package:nucore_project/core/extensions/margin_extn.dart';
import 'package:nucore_project/core/utils/app_colors.dart';
import 'package:nucore_project/core/utils/page_navigator.dart';
import 'package:nucore_project/presentation/widgets/app_text.dart';

abstract class CustomSnackbar {
  static void snackBar({
    required String message,
    bool isSuccess = false,
    bool isFailed = false,
    bool isExit = false,
  }) {
    final color = isSuccess
        ? AppColors.appGreen
        : isFailed
        ? AppColors.appRed
        : AppColors.appBlue;

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            isSuccess
                ? Icons.check_circle_outline
                : isFailed
                ? Icons.cancel_outlined
                : Icons.info_outline,
            color: color,
            size: 26,
          ),
          10.wBox,
          Expanded(
            child: AppText(
              maxLines: 2,
              message,
              color: isSuccess
                  ? const Color.fromARGB(255, 44, 140, 46)
                  : isFailed
                  ? const Color.fromARGB(255, 147, 49, 19)
                  : const Color.fromARGB(255, 20, 84, 136),
              family: lexend500,
            ),
          ),
        ],
      ),
      backgroundColor: isSuccess
          ? Colors.green.shade50
          : isFailed
          ? Colors.red.shade50
          : Colors.blue.shade50,
      margin: EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      elevation: 2.5,
      showCloseIcon: true,
      duration: Duration(seconds: 3),
      closeIconColor: AppColors.appGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(width: 0.5, color: color),
      ),
      action: isExit == true
          ? SnackBarAction(
              label: "Exit",
              textColor: AppColors.appRed,
              onPressed: () {
                SystemNavigator.pop();
              },
            )
          : null,
    );

    if (NavigationService.context?.mounted != true) return;

    ScaffoldMessenger.of(NavigationService.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    // ScaffoldMessenger.of(NavigationService.context!).clearSnackBars();

    // ScaffoldMessenger.of(NavigationService.context!).showSnackBar(snackBar);
  }

  static void exitSnackbar() {
    snackBar(message: "Exit from app?", isExit: true);
  }

  static void successSnackbar(String? message) {
    snackBar(message: message ?? "Success", isSuccess: true);
  }

  static void failedSnackbar(String? message) {
    snackBar(message: message ?? "Something went wrong", isFailed: true);
  }
}
