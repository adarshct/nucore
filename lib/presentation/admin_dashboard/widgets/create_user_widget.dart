import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nucore_project/core/constants/font_strings.dart';
import 'package:nucore_project/core/extensions/margin_extn.dart';
import 'package:nucore_project/core/utils/app_colors.dart';
import 'package:nucore_project/core/utils/custom_validators.dart';
import 'package:nucore_project/presentation/admin_dashboard/admin_dashboard_cubit.dart';
import 'package:nucore_project/presentation/widgets/app_button.dart';
import 'package:nucore_project/presentation/widgets/app_text.dart';
import 'package:nucore_project/presentation/widgets/app_text_field.dart';

class CreateUserWidget extends StatelessWidget {
  const CreateUserWidget({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
      builder: (context, state) {
        final cubit = context.read<AdminDashboardCubit>();

        return Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                15.hBox,
                AppText("Create User", size: 15, family: lexend600),
                15.hBox,
                AppTextField(
                  controller: cubit.nameController,
                  hint: "Enter Name",
                  validator: (val) {
                    if (val?.isEmpty ?? true) {
                      return "Enter User's Name";
                    }
                    return null;
                  },
                ),
                15.hBox,
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
                15.hBox,
                AppText("Select Role", color: AppColors.appGrey, size: 13),

                DropdownButton(
                  dropdownColor: AppColors.white,
                  value: state.role,
                  hint: AppText("Select Role", color: AppColors.appGrey),
                  items: [
                    DropdownMenuItem(value: "user", child: AppText("User")),
                    DropdownMenuItem(value: "admin", child: AppText("Admin")),
                  ],
                  onChanged: (value) {
                    cubit.swapRole(value!);
                  },
                ),
                15.hBox,
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
                15.hBox,
                AppTextField(
                  hint: "Confirm Password",
                  validator: (val) {
                    if (val?.isEmpty ?? true) {
                      return "Enter password";
                    } else if (val != cubit.passwordController.text) {
                      return "Password shoul be same";
                    }
                    return null;
                  },
                ),
                20.hBox,
                AppButton(
                  onPressed: () async {
                    if (cubit.formKey.currentState!.validate()) {
                      if (id == null) {
                        await cubit.createUser();
                      } else {
                        await cubit.createUser(id: id);
                      }
                    }
                  },
                  text: "Submit",
                ),
                20.hBox,
              ],
            ),
          ),
        );
      },
    );
  }
}
