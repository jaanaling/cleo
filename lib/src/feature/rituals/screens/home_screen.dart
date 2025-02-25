import 'package:cleopatras_secrets/src/core/utils/app_icon.dart';
import 'package:cleopatras_secrets/src/core/utils/icon_provider.dart';
import 'package:cleopatras_secrets/src/core/utils/size_utils.dart';
import 'package:cleopatras_secrets/src/feature/rituals/bloc/user_bloc.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/advice.dart';
import 'package:cleopatras_secrets/ui_kit/animated_button.dart';
import 'package:cleopatras_secrets/ui_kit/gradient_text_with_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../routes/root_navigation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    )),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: Row(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedButton(
                                    child: AppIcon(
                                      asset: IconProvider.statistic
                                          .buildImageUrl(),
                                      width: getWidth(context, baseSize: 69),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    onPressed: () {}),
                                Gap(10),
                                AnimatedButton(
                                    child: AppIcon(
                                      asset:
                                          IconProvider.advice.buildImageUrl(),
                                      width: getWidth(context, baseSize: 69),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isAdviceVisible = true;
                                      });
                                    })
                              ],
                            ),
                            Spacer(),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                AppIcon(
                                  asset: IconProvider.chart.buildImageUrl(),
                                  width: getWidth(context, baseSize: 141),
                                  fit: BoxFit.fitWidth,
                                ),
                                Text(user.getOverallStatus().toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      AnimatedButton(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AppIcon(
                                asset: IconProvider.sleepBack.buildImageUrl(),
                                width: getWidth(context, baseSize: 76),
                                fit: BoxFit.fitWidth,
                              ),
                              AppIcon(
                                asset: IconProvider.sleep.buildImageUrl(),
                                width: getWidth(context, baseSize: 31),
                                fit: BoxFit.fitWidth,
                              )
                            ],
                          ),
                          onPressed: () {}),
                      Gap(14),
                      AnimatedButton(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AppIcon(
                                asset: IconProvider.waterBack.buildImageUrl(),
                                width: getWidth(context, baseSize: 76),
                                fit: BoxFit.fitWidth,
                              ),
                              AppIcon(
                                asset: IconProvider.water.buildImageUrl(),
                                width: getWidth(context, baseSize: 31),
                                fit: BoxFit.fitWidth,
                              )
                            ],
                          ),
                          onPressed: () {}),
                      Gap(14),
                      AnimatedButton(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AppIcon(
                                asset: IconProvider.foodBack.buildImageUrl(),
                                width: getWidth(context, baseSize: 76),
                                fit: BoxFit.fitWidth,
                              ),
                              AppIcon(
                                asset: IconProvider.food.buildImageUrl(),
                                width: getWidth(context, baseSize: 31),
                                fit: BoxFit.fitWidth,
                              )
                            ],
                          ),
                          onPressed: () {}),
                      Spacer(
                        flex: 1,
                      ),
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
                      onPressed: () {}),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}

class AdviceScreen extends StatelessWidget {
  final List<Advice> advices;
  final VoidCallback onClose;
  const AdviceScreen({super.key, required this.advices, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedButton(
              child: AppIcon(
                asset: IconProvider.closeRounded.buildImageUrl(),
                width: getWidth(
                  context,
                  baseSize: 69,
                ),
                fit: BoxFit.fitWidth,
              ),
              onPressed: onClose),
          Gap(20),
          Stack(
            children: [
              AppIcon(
                asset: IconProvider.adviceBack.buildImageUrl(),
                // height: getHeight(context, baseSize: 461),
                width: getWidth(context, baseSize: 310),
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GradientText(
                        advices.first.title,
                        isCenter: true,
                        fontSize: 65,
                      ),
                    ),
                    Gap(20),
                    Text(
                      advices.first.content,
                      style: TextStyle(fontSize: 31),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
