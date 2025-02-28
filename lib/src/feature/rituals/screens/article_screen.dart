import 'package:cleopatras_secrets/routes/go_router_config.dart';
import 'package:cleopatras_secrets/src/core/utils/app_icon.dart';
import 'package:cleopatras_secrets/src/core/utils/icon_provider.dart';
import 'package:cleopatras_secrets/src/core/utils/size_utils.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/articles.dart';
import 'package:cleopatras_secrets/ui_kit/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui_kit/gradient_text_with_border.dart';

class ArticleScreen extends StatelessWidget {
  final Articles article;
  const ArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                Gap(15),
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
                        article.title,
                        fontSize: 70,
                        isCenter: true,
                      ),
                    ),
                    Spacer()
                  ],
                ),
                Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AppIcon(
                        asset: IconProvider.articleBack.buildImageUrl(),
                        width: getWidth(context, percent: 1) - 19,
                        height: getHeight(context, baseSize: 591),
                        fit: BoxFit.fill,
                      ),
                    
                   
                      SizedBox(
                        height: getHeight(context, baseSize: 560),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 43, vertical: 20),
                            child: Text(
                              article.content,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
