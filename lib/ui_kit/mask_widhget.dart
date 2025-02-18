import 'package:cleopatras_secrets/src/core/utils/app_icon.dart';
import 'package:cleopatras_secrets/src/core/utils/icon_provider.dart';
import 'package:cleopatras_secrets/ui_kit/app_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaskWidhget extends StatelessWidget {
  final Screen screen;
  final VoidCallback setState;
  const MaskWidhget({super.key, required this.screen, required this.setState});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      Container(
        color: Colors.black.withOpacity(0.7799999833106995),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
      ),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Gap(
                MediaQuery.of(context).size.height * 0.147 -
                    MediaQuery.of(context).padding.top,
              ),
              Gap(10),
              Text(
                screen.text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: -(MediaQuery.of(context).size.height * 0.108),
        child: AppIcon(
          asset: IconProvider.mask.buildImageUrl(),
          width: MediaQuery.of(context).size.width * 0.986,
          height: MediaQuery.of(context).size.height * 0.73,
        ),
      ),
      Positioned(
        bottom: 0,
        child: Padding(
          padding: EdgeInsets.only(bottom: 104),
          child: AppButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool(screen.code, true);
              setState();
            },
            color: BColor.green,
            text: "Go It!",
          ),
        ),
      ),
    ]);
  }
}

enum Screen {
  Chicken(
      "Here you can see all the chickens in the selected coop. Tap the plus button to add a new chicken.",
      "isChicken"),
  Create(
      "I've been waiting for you! Add or modify a coop by entering its name, size, and uploading an image. Save your changes so that they appear in the list.... Oh, and don't forget to tag who lives there",
      "isCreate"),
  Detailed(
      "This section displays detailed information about the selected coop. Complete the tasks to maintain our good cluck-cluck!",
      "isDetailed"),
  Home(
      "Welcome, cluck-cluck! Here you can see a list of all your coops, their size and the number of uncompleted tasks. But right now you don't have any... We're going to cluck that! Click the plus icon below. I'm already waiting for you there, cluck-cluck!",
      "isHome"),
  Task(
      "Here you can manage tasks by marking them as completed. Switch between tabs to view all tasks, overdue tasks and history",
      "isTask");

  final String text;
  final String code;
  const Screen(this.text, this.code);
}
