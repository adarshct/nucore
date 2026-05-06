import 'package:flutter/material.dart';
import 'package:nucore_project/core/constants/font_strings.dart';
import 'package:nucore_project/core/utils/app_colors.dart';
import 'package:nucore_project/presentation/widgets/app_text.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.validator,
    this.controller,
  });

  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(decorationThickness: 0, fontFamily: lexend400),
      decoration: InputDecoration(
        hint: AppText(hint, color: AppColors.appGrey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: border(),
        focusedBorder: border(),
        errorBorder: border(),
        focusedErrorBorder: border(),
        errorStyle: TextStyle(decorationThickness: 0, fontFamily: lexend400),
      ),
      validator: validator,
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
  }
}
