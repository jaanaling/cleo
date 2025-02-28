import 'package:cleopatras_secrets/routes/go_router_config.dart';
import 'package:cleopatras_secrets/routes/route_value.dart';
import 'package:cleopatras_secrets/src/core/utils/app_icon.dart';
import 'package:cleopatras_secrets/src/core/utils/icon_provider.dart';
import 'package:cleopatras_secrets/src/core/utils/size_utils.dart';
import 'package:cleopatras_secrets/src/feature/rituals/bloc/user_bloc.dart';
import 'package:cleopatras_secrets/ui_kit/animated_button.dart';
import 'package:cleopatras_secrets/ui_kit/gradient_text_with_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RitualsScreen extends StatefulWidget {
  const RitualsScreen({super.key});

  @override
  State<RitualsScreen> createState() => _RitualsScreenState();
}

class _RitualsScreenState extends State<RitualsScreen> {
   int daytime = 1;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        final item = state.rituals
            .where((test) => test.daytime == daytime)
            .where((test) => test.title.contains(_controller.text) )
            .toList();
        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: getHeight(context, baseSize: 80)),
              child: SafeArea(
                child: Column(
                  children: [
                    Opacity(opacity: 0, child: SizedBox(width: getWidth(context, percent: 0.6), child: AppTextField(controller: _controller))),
                    Gap(20),
                    Opacity(opacity: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedButton(
                            onPressed: () {
                              {
                                setState(() {
                                  daytime = 1;
                                });
                              }
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AppIcon(
                                  asset: daytime == 1
                                      ? IconProvider.greenButton.buildImageUrl()
                                      : IconProvider.blueButton.buildImageUrl(),
                                  width: getWidth(context, percent: 0.3),
                                ),
                                Text(
                                  "morning",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),AnimatedButton(
                            onPressed: () {
                              {
                                setState(() {
                                  daytime = 2;
                                });
                              }
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AppIcon(
                                  asset: daytime == 2
                                      ? IconProvider.greenButton.buildImageUrl()
                                      : IconProvider.blueButton.buildImageUrl(),
                                  width: getWidth(context, percent: 0.3),
                                ),
                                Text(
                                  "day",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),AnimatedButton(
                            onPressed: () {
                              {
                                setState(() {
                                  daytime = 3;
                                });
                              }
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AppIcon(
                                  asset: daytime == 3
                                      ? IconProvider.greenButton.buildImageUrl()
                                      : IconProvider.blueButton.buildImageUrl(),
                                  width: getWidth(context, percent: 0.3),
                                ),
                                Text(
                                  "evening",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      itemCount: item.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final task = item[index];
                        return Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 35),
                              child: AppIcon(
                                asset: IconProvider.articleButton.buildImageUrl(),
                                width: getWidth(context, percent: 1) - 14,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        AppIcon(
                                          asset: getCategoryImage(task.category),
                                          width: getWidth(context, percent: 0.2),
                                          fit: BoxFit.fitWidth,
                                        ),
                                        Gap(7),
                                        SizedBox(
                                          width: getWidth(context, percent: 0.5),
                                          child: GradientText(
                                            task.title,
                                            fontSize: 53,
                                            isCenter: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(17),
                                  Text(
                                    task.description,
                                    style: TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 20,
                              child: AnimatedButton(
                                onPressed: () {
                                  {
                                    context.push(
                                        "${RouteValue.rituals.path}/${RouteValue.ritual.path}",
                                        extra: task);
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AppIcon(
                                      asset: IconProvider.greenButton.buildImageUrl(),
                                      width: getWidth(context, percent: 0.3),
                                    ),
                                    Text(
                                      "Start",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: getWidth(context, percent: 0.6), child: AppTextField(controller: _controller)),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedButton(
                        onPressed: () {
                          {
                            setState(() {
                              daytime = 1;
                            });
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AppIcon(
                              asset: daytime == 1
                                  ? IconProvider.greenButton.buildImageUrl()
                                  : IconProvider.blueButton.buildImageUrl(),
                              width: getWidth(context, percent: 0.3),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: getHeight(context, baseSize: 3)),
                              child: Text(
                                "morning",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),AnimatedButton(
                        onPressed: () {
                          {
                            setState(() {
                              daytime = 2;
                            });
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AppIcon(
                              asset: daytime == 2
                                  ? IconProvider.greenButton.buildImageUrl()
                                  : IconProvider.blueButton.buildImageUrl(),
                              width: getWidth(context, percent: 0.3),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: getHeight(context, baseSize: 3)),
                              child: Text(
                                "day",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),AnimatedButton(
                        onPressed: () {
                          {
                            setState(() {
                              daytime = 3;
                            });
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AppIcon(
                              asset: daytime == 3
                                  ? IconProvider.greenButton.buildImageUrl()
                                  : IconProvider.blueButton.buildImageUrl(),
                              width: getWidth(context, percent: 0.3),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: getHeight(context, baseSize: 3)),
                              child: Text(
                                "evening",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String getCategoryImage(String category) {
    switch (category) {
      case "Self-Care":
        return IconProvider.selfCare.buildImageUrl();
      case "Nutrition":
        return IconProvider.nutrition.buildImageUrl();
      case "Social Connections":
        return IconProvider.socialConnections.buildImageUrl();
      case "Mental Health":
        return IconProvider.mentalHealth.buildImageUrl();
      case "Nature Practices":
        return IconProvider.naturalPractices.buildImageUrl();
      case "Physical Activity":
        return IconProvider.physicalActivity.buildImageUrl();
      case "Sleep and Rest":
        return IconProvider.sleepRest.buildImageUrl();
      default:
        return IconProvider.nutrition.buildImageUrl();
    }
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: controller,
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF510202),
          ),
          suffix: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(IconProvider.search.buildImageUrl()),
                fit: BoxFit.fill,
              ),
            ),
          ),
          textAlign: TextAlign.center,
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(IconProvider.searchPanel.buildImageUrl()),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
