import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nucore_project/core/constants/font_strings.dart';
import 'package:nucore_project/core/extensions/margin_extn.dart';
import 'package:nucore_project/core/utils/app_colors.dart';
import 'package:nucore_project/data/models/login_response_model.dart';
import 'package:nucore_project/presentation/admin_dashboard/admin_dashboard_cubit.dart';
import 'package:nucore_project/presentation/admin_dashboard/admin_dashboard_screen.dart';
import 'package:nucore_project/presentation/widgets/app_text.dart';

class AdminDashboardTile extends StatelessWidget {
  const AdminDashboardTile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
      builder: (context, state) {
        final cubit = context.read<AdminDashboardCubit>();

        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.appGrey.withAlpha(50),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.person_2_outlined, color: AppColors.appOrange),
              10.wBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(user.name, family: lexend500),
                    AppText(
                      user.email,
                      color: AppColors.appGrey,
                      size: 12,
                      family: lexend500,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  AdminDashboardScreen().userUpdateSheet(
                    context: context,
                    cubit: cubit,
                    user: user,
                  );
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.lightGrey,
                  radius: 15,
                  child: Icon(Icons.edit, color: AppColors.appGrey, size: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
