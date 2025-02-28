import 'package:cleopatras_secrets/src/core/utils/app_icon.dart';
import 'package:cleopatras_secrets/src/core/utils/icon_provider.dart';
import 'package:cleopatras_secrets/src/core/utils/size_utils.dart';
import 'package:cleopatras_secrets/src/feature/rituals/bloc/user_bloc.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/rituals.dart';
import 'package:cleopatras_secrets/ui_kit/animated_button.dart';
import 'package:cleopatras_secrets/ui_kit/gradient_text_with_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RitualScreen extends StatefulWidget {
  final Rituals ritual;
  const RitualScreen({super.key, required this.ritual});

  @override
  State<RitualScreen> createState() => _RitualScreenState();
}

class _RitualScreenState extends State<RitualScreen> {
  int currentStep = 1;
  int id = 0;
  bool isFinal = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Color(0x752D0202)),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 105),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedButton(
                          child: AppIcon(
                            asset: IconProvider.back.buildImageUrl(),
                            width: getWidth(context, baseSize: 69),
                            fit: BoxFit.fitWidth,
                          ),
                          onPressed: () {
                            context.pop();
                          }),
                      Spacer(),
                      SizedBox(
                        width: getWidth(context, percent: 1) -
                            getWidth(context, baseSize: 69) -
                            40,
                        child: GradientText(
                          widget.ritual.title,
                          fontSize: 50,
                          isCenter: true,
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                  Gap(36),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        Gap(37),
                        ListView.separated(
                          itemCount: widget.ritual.stages.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildStepItem(
                              stepNumber: index + 1,
                              text: widget.ritual.stages[index].title,
                              visible: currentStep - 1 >= index,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            widget.ritual.stages[id].description,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 30),
                        LinearPercentIndicator(
                          percent: currentStep < widget.ritual.stages.length
                              ? currentStep / widget.ritual.stages.length
                              : 1,
                          width: 233,
                          alignment: MainAxisAlignment.center,
                          lineHeight: 12,
                          backgroundColor: const Color(0xFF050A12),
                          linearGradient: const LinearGradient(
                            colors: [
                              Color(0xFFFEFE61),
                              Color(0xFF197C2F),
                            ],
                          ),
                          barRadius: const Radius.circular(32),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                        ),
                        const SizedBox(height: 35),
                        AnimatedButton(
                          onPressed: () {
                            currentStep++;
                            if (currentStep < widget.ritual.stages.length + 1) {
                              id++;
                            }
                            setState(() {
                              if (currentStep ==
                                  widget.ritual.stages.length + 1) {
                                isFinal = true;
                              }
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AppIcon(
                                asset: IconProvider.greenButton.buildImageUrl(),
                                width: getWidth(context, percent: 0.3),
                              ),
                              Text(
                                "Next",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 45),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isFinal) _buildFinalItem(),
      ],
    );
  }

  Widget _buildStepItem({
    required int stepNumber,
    required String text,
    required bool visible,
  }) {
    return Opacity(
        opacity: visible ? 1 : 0,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                DecoratedBox(
                  decoration: ShapeDecoration(
                      shape: OvalBorder(),
                      image: DecorationImage(
                          image: AssetImage(IconProvider.num.buildImageUrl()))),
                  child: SizedBox(
                    width: 53,
                    height: 53,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    '$stepNumber',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Kastore'),
                  ),
                )
              ],
            ),
            Gap(17),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'Kastore'),
              ),
            )
          ],
        ));
  }

  Widget _buildFinalItem() {
    return Stack(
      children: [
        Container(
          width: getWidth(context, percent: 1),
          height: getHeight(context, percent: 1),
          decoration: BoxDecoration(color: Color.fromARGB(117, 0, 0, 0)),
        ),
        Positioned(
          bottom: -100,
      
          child: Image.asset(
            IconProvider.mascot.buildImageUrl(),
            width: getWidth(context, percent: 1),
            height: getHeight(context, percent: 1),
           
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(context, percent: 0.1)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23, vertical: 12),
              child: GradientText(
                'I feel better now!',
                isCenter: true,
                fontSize: 60,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(context, percent: 0.2)),
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AppIcon(
                    asset: IconProvider.greenButton.buildImageUrl(),
                    width: getWidth(context, percent: 0.3),
                  ),
                  Text(
                    "Finish",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
