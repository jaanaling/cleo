import 'package:cleopatras_secrets/routes/go_router_config.dart';
import 'package:cleopatras_secrets/routes/route_value.dart';
import 'package:cleopatras_secrets/src/core/utils/app_icon.dart';
import 'package:cleopatras_secrets/src/core/utils/icon_provider.dart';
import 'package:cleopatras_secrets/src/core/utils/size_utils.dart';
import 'package:cleopatras_secrets/src/feature/rituals/bloc/user_bloc.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/advice.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/user.dart';
import 'package:cleopatras_secrets/ui_kit/animated_button.dart';
import 'package:cleopatras_secrets/ui_kit/gradient_text_with_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/root_navigation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int typeSelected = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const CupertinoActivityIndicator();
        }
        final user = state.user;
        return Stack(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  bottom: -getHeight(context, baseSize: 40),
                  left: 0,
                  child: AppIcon(
                    asset: IconProvider.mascot.buildImageUrl(),
                    height: getHeight(context, baseSize: 778),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 15,
                        ),
                        child: Row(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedButton(
                                  child: AppIcon(
                                    asset:
                                        IconProvider.statistic.buildImageUrl(),
                                    width: getWidth(context, baseSize: 69),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  onPressed: () {
                                    context.push(
                                      "${RouteValue.home.path}/${RouteValue.statistic.path}",
                                      extra: typeSelected,
                                    );
                                  },
                                ),
                                Gap(10),
                                AnimatedButton(
                                  child: AppIcon(
                                    asset: IconProvider.advice.buildImageUrl(),
                                    width: getWidth(context, baseSize: 69),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  onPressed: () {
                                    _showAlertDialog(context, state.advice);
                                  },
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AppIcon(
                                      asset: IconProvider.chart.buildImageUrl(),
                                      width: getWidth(context, baseSize: 141),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    GradientText(
                                      user
                                              .getOverallStatus()
                                              .toInt()
                                              .toString() +
                                          " %",
                                      fontSize: 50,
                                    ),
                                  ],
                                ),
                                GradientText(
                                  "General\n Condition",
                                  fontSize: 40,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(flex: 2),
                      AnimatedButton(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AppIcon(
                              asset: user.getSleepPercentage() < 30
                                  ? IconProvider.sleepBack.buildImageUrl()
                                  : user.getSleepPercentage() > 30 &&
                                          user.getSleepPercentage() < 70
                                      ? IconProvider.waterBack.buildImageUrl()
                                      : IconProvider.foodBack.buildImageUrl(),
                              width: getWidth(context, baseSize: 76),
                              fit: BoxFit.fitWidth,
                            ),
                            AppIcon(
                              asset: IconProvider.sleep.buildImageUrl(),
                              width: getWidth(context, baseSize: 31),
                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                      Gap(14),
                      AnimatedButton(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AppIcon(
                              asset:  user.getWaterPercentage() < 30
                                  ? IconProvider.sleepBack.buildImageUrl()
                                  : user.getWaterPercentage() > 30 &&
                                          user.getWaterPercentage() < 70
                                      ? IconProvider.waterBack.buildImageUrl()
                                      : IconProvider.foodBack.buildImageUrl(),
                              width: getWidth(context, baseSize: 76),
                              fit: BoxFit.fitWidth,
                            ),
                            AppIcon(
                              asset: IconProvider.water.buildImageUrl(),
                              width: getWidth(context, baseSize: 31),
                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                      Gap(14),
                      AnimatedButton(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AppIcon(
                              asset: user.getFoodPercentage() < 30
                                  ? IconProvider.sleepBack.buildImageUrl()
                                  : user.getFoodPercentage() > 30 &&
                                          user.getFoodPercentage() < 70
                                      ? IconProvider.waterBack.buildImageUrl()
                                      : IconProvider.foodBack.buildImageUrl(),
                              width: getWidth(context, baseSize: 76),
                              fit: BoxFit.fitWidth,
                            ),
                            AppIcon(
                              asset: IconProvider.food.buildImageUrl(),
                              width: getWidth(context, baseSize: 31),
                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
                Positioned(
                  right: 18,
                  bottom: getHeight(context, baseSize: 126),
                  child: AnimatedButton(
                    child: AppIcon(
                      asset: IconProvider.addRounded.buildImageUrl(),
                      width: getWidth(context, baseSize: 69),
                      fit: BoxFit.fitWidth,
                    ),
                    onPressed: () {
                      addStatusPopup(context, user);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

void _showAlertDialog(BuildContext context, List<Advice> advices) {
  int selectedIndex = 0;

  showDialog(
    context: context,
    useSafeArea: false,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: StatefulBuilder(
          builder:
              (context, StateSetter setState) => SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20),
                        AnimatedButton(
                          child: AppIcon(
                            asset: IconProvider.closeRounded.buildImageUrl(),
                            width: getWidth(context, baseSize: 69),
                            fit: BoxFit.fitWidth,
                          ),
                          onPressed: () => context.pop(),
                        ),
                        Spacer(),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            AppIcon(
                              asset: IconProvider.adviceBack.buildImageUrl(),
                              height: getHeight(context, baseSize: 461),
                              fit: BoxFit.fitHeight,
                            ),
                            SizedBox(
                              width: getWidth(context, baseSize: 260),
                              height: getHeight(context, baseSize: 430),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(
                                  bottom: getHeight(context, baseSize: 230),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      GradientText(
                                        advices[selectedIndex].title,
                                        isCenter: true,
                                        fontSize: 65,
                                      ),
                                      Gap(20),
                                      Text(
                                        advices[selectedIndex].content,
                                        style: TextStyle(
                                          fontSize: 31,
                                          fontFamily: 'Mulish',
                                          color: Color(0xFF783200),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(getHeight(context, baseSize: 200)),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: AppIcon(
                        asset: IconProvider.mascotAdvice.buildImageUrl(),
                        height: getHeight(context, baseSize: 440),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: getHeight(context, baseSize: 71),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.diagonal3Values(-1, 1, 1),
                            child: AnimatedButton(
                              onPressed: () {
                                if (selectedIndex > 0) {
                                  setState(() {
                                    selectedIndex--;
                                  });
                                }
                              },
                              child: AppIcon(
                                asset: IconProvider.arrow.buildImageUrl(),
                                width: getWidth(context, baseSize: 69),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Gap(getWidth(context, baseSize: 130)),
                          AnimatedButton(
                            onPressed: () {
                              if (selectedIndex < advices.length - 1) {
                                setState(() {
                                  selectedIndex++;
                                });
                              }
                            },
                            child: AppIcon(
                              asset: IconProvider.arrow.buildImageUrl(),
                              width: getWidth(context, baseSize: 69),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ),
      );
    },
  );
}

void addStatusPopup(BuildContext context, User user) {
  final TextEditingController waterController = TextEditingController();
  final TextEditingController foodController = TextEditingController();
  final TextEditingController sleepController = TextEditingController();

  showDialog(
    context: context,
    useSafeArea: false,
    barrierDismissible: false,
    builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).removeViewInsets(removeBottom: true),
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, StateSetter setState) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1,
                ),
                Container(
                  width: double.infinity,
                  height: 441,
                  decoration: ShapeDecoration(
                    color: Color(0xFFCE7E2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F002D71),
                        blurRadius: 9.60,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                          child: AnimatedButton(
                            child: AppIcon(
                              asset: IconProvider.close.buildImageUrl(),
                              width: getWidth(
                                context,
                                baseSize: 30,
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                            onPressed: () => context.pop(),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          TextFieldRow(
                            text: "h",
                            controller: sleepController,
                            icon: IconProvider.sleep.buildImageUrl(),
                            title: "Time of\nsleep",
                          ),
                          Gap(20),
                          TextFieldRow(
                            text: "ml",
                            controller: waterController,
                            icon: IconProvider.water.buildImageUrl(),
                            title: "Water",
                          ),
                          Gap(20),
                          TextFieldRow(
                            text: "",
                            controller: foodController,
                            icon: IconProvider.food.buildImageUrl(),
                            title: "Callories",
                          ),
                        ],
                      ),
                      AnimatedButton(
                          child: AppIcon(
                            asset: IconProvider.add.buildImageUrl(),
                            height: 82,
                          ),
                          onPressed: () {
                            context.read<UserBloc>().add(
                                  UserUpdateData(
                                    user: user.copyWith(
                                      sleep: Duration(
                                        hours: sleepController.text != ""
                                            ? int.parse(sleepController.text)
                                            : 0,
                                      ),
                                      water: waterController.text != ""
                                          ? int.parse(waterController.text)
                                          : 0,
                                      food: foodController.text != ""
                                          ? int.parse(foodController.text)
                                          : 0,
                                      waterHistory: waterController.text != ""
                                          ? [
                                              ...user.waterHistory,
                                              HistoryWater(
                                                time: DateTime.now(),
                                                water: int.parse(
                                                  waterController.text,
                                                ),
                                              ),
                                            ]
                                          : user.waterHistory,
                                      foodHistory: foodController.text != ""
                                          ? [
                                              ...user.foodHistory,
                                              ...user.foodHistory,
                                              HistoryFood(
                                                time: DateTime.now(),
                                                food: int.parse(
                                                  foodController.text,
                                                ),
                                              ),
                                            ]
                                          : user.foodHistory,
                                      sleepHistory: sleepController.text != ""
                                          ? [
                                              ...user.sleepHistory,
                                              HistorySleep(
                                                time: DateTime.now(),
                                                sleep: Duration(
                                                  hours: int.parse(
                                                    sleepController.text,
                                                  ),
                                                ),
                                              ),
                                            ]
                                          : user.sleepHistory,
                                    ),
                                  ),
                                );
                            context.pop();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class TextFieldRow extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String icon;
  final String title;

  const TextFieldRow({
    super.key,
    required this.icon,
    required this.title,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context, percent: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(asset: icon, width: 40),
          Gap(10),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Mulish',
              fontSize: 24,
              color: Color(0xFF741B00),
            ),
          ),
          Gap(10),
          SizedBox(
            width: getWidth(context, percent: 0.3),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: TextInputType.number,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              suffix: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Boleh",
                    color: const Color(0xFFFFD64E),
                  ),
                ),
              ),
              style: TextStyle(
                fontSize: 30,
                fontFamily: "Boleh",
                color: const Color(0xFFFFD64E),
              ),
              textAlign: TextAlign.center,
              padding: EdgeInsets.symmetric(
                vertical: getWidth(context, baseSize: 18),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(IconProvider.fieldBack.buildImageUrl()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
