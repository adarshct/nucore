import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nucore_project/core/constants/font_strings.dart';
import 'package:nucore_project/core/extensions/margin_extn.dart';
import 'package:nucore_project/core/utils/app_colors.dart';
import 'package:nucore_project/core/utils/device.dart';
import 'package:nucore_project/core/utils/local_storage.dart';
import 'package:nucore_project/core/utils/page_navigator.dart';
import 'package:nucore_project/data/models/login_response_model.dart';
import 'package:nucore_project/presentation/admin_dashboard/admin_dashboard_cubit.dart';
import 'package:nucore_project/presentation/admin_dashboard/widgets/admin_dashboard_tile.dart';
import 'package:nucore_project/presentation/admin_dashboard/widgets/create_user_widget.dart';
import 'package:nucore_project/presentation/login/login_screen.dart';
import 'package:nucore_project/presentation/widgets/app_button.dart';
import 'package:nucore_project/presentation/widgets/app_loader.dart';
import 'package:nucore_project/presentation/widgets/app_text.dart';
import 'package:nucore_project/presentation/widgets/empty_widget.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => AdminDashboardCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appRed,
          title: AppText(
            "Dashboard",
            color: AppColors.white,
            size: 18,
            family: lexend500,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await LocalStorage.clearData();
                openAsNewPage(LoginScreen());
              },
              icon: Icon(Icons.exit_to_app, color: AppColors.white),
            ),
          ],
        ),
        body: BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
          builder: (context, state) {
            final cubit = context.read<AdminDashboardCubit>();

            if (state.isLoading) return AppLoader();

            return Padding(
              padding: Device.horizontalPadding,
              child: Column(
                children: [
                  15.hBox,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText("Users", family: lexend600, size: 15),
                      AppButton(
                        height: 38,
                        width: 145,
                        textSize: 14,
                        onPressed: () {
                          userUpdateSheet(context: context, cubit: cubit);
                        },
                        text: "Create User +",
                      ),
                    ],
                  ),
                  15.hBox,
                  state.users.isEmpty
                      ? EmptyWidget()
                      : Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(top: 5, bottom: 20),
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              final user = state.users[index];

                              return AdminDashboardTile(user: user);
                            },
                            separatorBuilder: (context, index) => 15.hBox,
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void userUpdateSheet({
    required BuildContext context,
    required AdminDashboardCubit cubit,
    User? user,
  }) {
    if (user != null) {
      cubit.nameController.text = user.name!;
      cubit.emailController.text = user.email!;
      cubit.swapRole(user.role!);
    } else {
      cubit.nameController.clear();
      cubit.emailController.clear();
      cubit.passwordController.clear();
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      elevation: 5,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider.value(
          value: cubit,
          child: CreateUserWidget(id: user?.id),
        );
      },
    );
  }
}
