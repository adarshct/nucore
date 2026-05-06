import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nucore_project/core/constants/font_strings.dart';
import 'package:nucore_project/core/extensions/margin_extn.dart';
import 'package:nucore_project/core/utils/app_colors.dart';
import 'package:nucore_project/core/utils/custom_validators.dart';
import 'package:nucore_project/core/utils/device.dart';
import 'package:nucore_project/presentation/login/login_cubit.dart';
import 'package:nucore_project/presentation/widgets/app_button.dart';
import 'package:nucore_project/presentation/widgets/app_text.dart';
import 'package:nucore_project/presentation/widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            final cubit = context.read<LoginCubit>();

            return Center(
              child: SingleChildScrollView(
                padding: Device.horizontalPadding,
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        "LOGIN",
                        family: lexend600,
                        size: 30,
                        color: AppColors.appOrange,
                      ),
                      50.hBox,
                      AppTextField(
                        controller: cubit.emailController,
                        hint: "Enter Email",
                        validator: (val) {
                          if (!CustomValidators.emailValidator(value: val!)) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                      ),
                      30.hBox,
                      AppTextField(
                        controller: cubit.passwordController,
                        hint: "Enter Password",
                        validator: (val) {
                          if (val?.isEmpty ?? true) {
                            return "Enter password";
                          }
                          return null;
                        },
                      ),
                      40.hBox,
                      AppButton(
                        isLoading: state.isLoading,
                        onPressed: () async {
                          Device.closeKeyboard();
                          if (cubit.formKey.currentState!.validate()) {
                            await cubit.login();
                          }
                        },
                        text: "Login",
                      ),
                      30.hBox,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
