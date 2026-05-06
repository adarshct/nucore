import 'package:flutter/material.dart';
import 'package:nucore_project/presentation/widgets/app_text.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: AppText("Something went wrong"));
  }
}
