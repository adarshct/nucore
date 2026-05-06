import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nucore_project/core/constants/font_strings.dart';
import 'package:nucore_project/core/extensions/margin_extn.dart';
import 'package:nucore_project/core/utils/app_colors.dart';
import 'package:nucore_project/core/utils/device.dart';
import 'package:nucore_project/core/utils/local_storage.dart';
import 'package:nucore_project/core/utils/page_navigator.dart';
import 'package:nucore_project/data/models/summary_model.dart';
import 'package:nucore_project/presentation/login/login_screen.dart';
import 'package:nucore_project/presentation/user_dashboard/user_dashboard_cubit.dart';
import 'package:nucore_project/presentation/user_dashboard/widgets/hourly_purchase_graph.dart';
import 'package:nucore_project/presentation/widgets/app_text.dart';
import 'package:nucore_project/presentation/widgets/empty_widget.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => UserDashboardCubit(),
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
        body: BlocBuilder<UserDashboardCubit, UserDashboardState>(
          builder: (context, state) {
            if (state.summary == null) return EmptyWidget();

            return Padding(
              padding: Device.horizontalPadding,
              child: Column(
                children: [
                  15.hBox,
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.appGrey.withAlpha(50),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText("Total Revenue", size: 15, family: lexend500),
                        AppText(
                          "₹25233",
                          color: AppColors.appOrange,
                          size: 16,
                          family: lexend600,
                        ),
                      ],
                    ),
                  ),
                  20.hBox,
                  pieChart(),
                  30.hBox,
                  AppText("Hourly Purchase", family: lexend600),
                  15.hBox,
                  HourlyPurchaseGraph(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget pieChart() {
    return BlocBuilder<UserDashboardCubit, UserDashboardState>(
      builder: (context, state) {
        DashboardResponse data = state.summary!;

        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 130,
              width: 130,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  sections: [
                    PieChartSectionData(
                      value: double.parse(data.successful!.count.toString()),
                      color: AppColors.appGreen,
                      radius: 18,
                      showTitle: false,
                    ),

                    PieChartSectionData(
                      value: double.parse(data.cancelled!.count.toString()),
                      color: AppColors.appRed,
                      radius: 18,
                      showTitle: false,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText("1246", size: 18, family: lexend600),
                AppText(
                  "Total Sales",
                  color: AppColors.appGrey,
                  family: lexend500,
                  size: 11,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
