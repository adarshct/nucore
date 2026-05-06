import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nucore_project/core/constants/assets_helper.dart';
import 'package:nucore_project/core/utils/device.dart';
import 'package:nucore_project/presentation/splash/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => SplashCubit(),
      child: Scaffold(
        body: SizedBox(
          width: Device.width,
          height: Device.height,
          child: Image.asset(AssetsHelper.splash, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
