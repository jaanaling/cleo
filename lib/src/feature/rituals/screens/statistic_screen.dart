import 'package:cleopatras_secrets/src/feature/rituals/bloc/user_bloc.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticScreen extends StatefulWidget {
  final int typeSelected;

  const StatisticScreen({super.key, required this.typeSelected});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.typeSelected;
  }

  List<ChartData> getFilteredData(List<HistoryWater> waterHistory,
      List<HistorySleep> sleepHistory, List<HistoryFood> foodHistory) {
    if (selectedIndex == 2) {
      return waterHistory
          .map((historyWater) => ChartData(
                time: historyWater.time,
                value: historyWater.water.toDouble(),
              ))
          .toList();
    } else if (selectedIndex == 1) {
      return sleepHistory
          .map((historySleep) => ChartData(
                time: historySleep.time,
                value: historySleep.sleep.inHours.toDouble(),
              ))
          .toList();
    } else {
      return foodHistory
          .map((historyFood) => ChartData(
                time: historyFood.time,
                value: historyFood.food.toDouble(),
              ))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        List<ChartData> chartData = getFilteredData(state.user.waterHistory,
            state.user.sleepHistory, state.user.foodHistory);

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Water History',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //   isWaterSelected = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Sleep History',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SfCartesianChart(
              primaryXAxis: DateTimeAxis(),
              primaryYAxis: NumericAxis(minimum: 0, interval: 1),
              series: [
                LineSeries<ChartData, DateTime>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.time,
                  yValueMapper: (ChartData data, _) => data.value,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class ChartData {
  final DateTime time;
  final double value;

  ChartData({required this.time, required this.value});
}
