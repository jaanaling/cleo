import 'package:cleopatras_secrets/src/core/utils/app_icon.dart';
import 'package:cleopatras_secrets/src/core/utils/icon_provider.dart';
import 'package:cleopatras_secrets/src/core/utils/size_utils.dart';
import 'package:cleopatras_secrets/src/feature/rituals/bloc/user_bloc.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/user.dart';
import 'package:cleopatras_secrets/ui_kit/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticScreen extends StatefulWidget {
  final int typeSelected;

  const StatisticScreen({super.key, required this.typeSelected});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  int selectedIndex = 0;
  bool isDay = true;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.typeSelected;
  }

  List<ChartData> getFilteredData(
      List<HistoryWater> waterHistory,
      List<HistorySleep> sleepHistory,
      List<HistoryFood> foodHistory,
      bool isDaySelected) {
    DateTime now = DateTime.now();

    if (!isDaySelected) {
      // Filter for the entire month
      if (selectedIndex == 2) {
        return waterHistory
            .where((historyWater) =>
                historyWater.time.year == now.year &&
                historyWater.time.month == now.month)
            .map((historyWater) => ChartData(
                  time: historyWater.time,
                  value: historyWater.water.toDouble(),
                ))
            .toList();
      } else if (selectedIndex == 1) {
        return sleepHistory
            .where((historyWater) =>
                historyWater.time.year == now.year &&
                historyWater.time.month == now.month)
            .map((historySleep) => ChartData(
                  time: historySleep.time,
                  value: historySleep.sleep.inHours.toDouble(),
                ))
            .toList();
      } else {
        return foodHistory
            .where((historyWater) =>
                historyWater.time.year == now.year &&
                historyWater.time.month == now.month)
            .map((historyFood) => ChartData(
                  time: historyFood.time,
                  value: historyFood.food.toDouble(),
                ))
            .toList();
      }
    } else {
      // Filter for the current day
      if (selectedIndex == 2) {
        return waterHistory
            .where((historyWater) =>
                historyWater.time.year == now.year &&
                historyWater.time.month == now.month &&
                historyWater.time.day == now.day)
            .map((historyWater) => ChartData(
                  time: historyWater.time,
                  value: historyWater.water.toDouble(),
                ))
            .toList();
      } else if (selectedIndex == 1) {
        return sleepHistory
            .where((historyWater) =>
                historyWater.time.year == now.year &&
                historyWater.time.month == now.month &&
                historyWater.time.day == now.day)
            .map((historySleep) => ChartData(
                  time: historySleep.time,
                  value: historySleep.sleep.inHours.toDouble(),
                ))
            .toList();
      } else {
        return foodHistory
            .where((historyWater) =>
                historyWater.time.year == now.year &&
                historyWater.time.month == now.month &&
                historyWater.time.day == now.day)
            .map((historyFood) => ChartData(
                  time: historyFood.time,
                  value: historyFood.food.toDouble(),
                ))
            .toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is! UserLoaded) {
                return const Center(child: CircularProgressIndicator());
              }
              List<ChartData> chartData = getFilteredData(
                  state.user.waterHistory,
                  state.user.sleepHistory,
                  state.user.foodHistory,
                  isDay);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedButton(
                    child: AppIcon(
                      asset: IconProvider.back.buildImageUrl(),
                      width: getWidth(context, baseSize: 69),
                      fit: BoxFit.fitWidth,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(height: 20),
                  AnimatedButton(
                    onPressed: () {
                      setState(() {
                        if (selectedIndex == 3) {
                          selectedIndex = 1;
                        } else {
                          selectedIndex++;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      margin: const EdgeInsets.only(right: 100),
                      decoration: ShapeDecoration(
                        color: Colors.black.withOpacity(0.5600000023841858),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(38.50),
                            bottomRight: Radius.circular(38.50),
                          ),
                        ),
                        shadows: [
                          const BoxShadow(
                            color: Color(0x87000C4A),
                            blurRadius: 5.30,
                            offset: Offset(0, 1),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          AppIcon(
                            asset: selectedIndex == 1
                                ? IconProvider.sleep.buildImageUrl()
                                : selectedIndex == 2
                                    ? IconProvider.water.buildImageUrl()
                                    : IconProvider.food.buildImageUrl(),
                            height: 46,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedIndex == 1
                                ? 'Sleep History'
                                : selectedIndex == 2
                                    ? 'Water History'
                                    : 'Food History',
                            style: TextStyle(
                              color: Color(0xFFFFE4D2),
                              fontSize: 23,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.69,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context, percent: 0.2),
                        vertical: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            IconProvider.switchBack.buildImageUrl(),
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDay = true;
                                });
                              },
                              child: isDay
                                  ? AppIcon(
                                      asset: IconProvider.day.buildImageUrl(),
                                      height: 46,
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 8,
                                      ),
                                      child: const Text(
                                        'Day',
                                        style: TextStyle(
                                          color: Color(0xFF3E1900),
                                          fontSize: 23,
                                          fontFamily: 'Mulish',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.69,
                                        ),
                                      ),
                                    ),
                            ),
                            if (!isDay)
                              AppIcon(
                                asset: IconProvider.month.buildImageUrl(),
                                height: 46,
                              )
                            else
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isDay = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 8,
                                  ),
                                  child: const Text(
                                    'Month',
                                    style: TextStyle(
                                      color: Color(0xFF3E1900),
                                      fontSize: 23,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.69,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: getHeight(context, percent: 0.35),
                    child: SfCartesianChart(
                      primaryXAxis: DateTimeAxis(
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w300,
                            height: 0.55,
                            letterSpacing: -0.45,
                          ),
                         ),
                      primaryYAxis: NumericAxis(
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w300,
                            height: 0.55,
                            letterSpacing: -0.45,
                          ),
                          minimum: 0,
                          interval: isDay
                              ? (selectedIndex == 1 ? 10 : 500)
                              : (selectedIndex == 1 ? 10 : 1000)),
                      series: [
                        LineSeries<ChartData, DateTime>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.time,
                          yValueMapper: (ChartData data, _) => data.value,
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w300,
                              height: 0.55,
                              letterSpacing: -0.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class ChartData {
  final DateTime time;
  final double value;

  ChartData({required this.time, required this.value});
}
