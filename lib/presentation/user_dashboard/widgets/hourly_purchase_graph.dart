import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nucore_project/core/constants/font_strings.dart';
import 'package:nucore_project/core/extensions/margin_extn.dart';
import 'package:nucore_project/core/utils/app_colors.dart';
import 'package:nucore_project/presentation/widgets/app_text.dart';

class HourlyPurchaseGraph extends StatelessWidget {
  const HourlyPurchaseGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> xLabels = [
      "Hour 1",
      "Hour 2",
      "Hour 3",
      "Hour 4",
      "Hour 5",
      "Hour 6",
      "Hour 7",
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        15.hBox,
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => AppColors.black,
                  tooltipPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.asMap().entries.map((entry) {
                      final index = entry.key;
                      final e = entry.value;

                      if (index == 0) {
                        final int xIndex = e.x.toInt();
                        final String xText = xLabels[xIndex];

                        return LineTooltipItem(
                          "$xText\n${e.y}",
                          TextStyle(
                            color: AppColors.white,
                            fontFamily: lexend500,
                            fontSize: 12,
                          ),
                        );
                      }
                    }).toList();
                  },
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: AppColors.lightGrey,
                    strokeWidth: 1,
                    dashArray: [7, 7],
                  );
                },
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 45,
                    showTitles: true,
                    interval: 20000,
                    getTitlesWidget: (value, meta) {
                      return commonText("₹ ${(value ~/ 1000)}k");
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    interval: 1,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: commonText(xLabels[value.toInt()]),
                      );
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(bottom: BorderSide(color: AppColors.lightGrey)),
              ),
              lineBarsData: [
                LineChartBarData(
                  isCurved: false,
                  spots: const [
                    FlSpot(0, 25000),
                    FlSpot(1, 40000),
                    FlSpot(2, 28000),
                    FlSpot(3, 48000),
                    FlSpot(4, 35000),
                    FlSpot(5, 42000),
                    FlSpot(6, 65000),
                  ],
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (p0, p1, p2, p3) {
                      return FlDotCirclePainter(
                        radius: 3,
                        color: AppColors.appOrange,
                      );
                    },
                  ),
                  color: AppColors.appOrange,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.appOrange.withAlpha(50),
                        AppColors.appOrange.withAlpha(25),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
              minY: 0,
              maxY: 80000,
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: 80000,
                    color: AppColors.lightGrey,
                    strokeWidth: 1,
                    dashArray: [7, 7],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget commonText(String text) {
    return AppText(text, size: 10, family: lexend600, color: AppColors.appGrey);
  }
}
