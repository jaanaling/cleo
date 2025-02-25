import 'package:cleopatras_secrets/src/core/utils/size_utils.dart';
import 'package:cleopatras_secrets/src/core/utils/text_with_border.dart';
import 'package:cleopatras_secrets/src/feature/rituals/bloc/user_bloc.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/articles.dart';
import 'package:cleopatras_secrets/ui_kit/animated_button.dart';
import 'package:cleopatras_secrets/ui_kit/gradient_text_with_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/route_value.dart';
import '../../../core/utils/app_icon.dart';
import '../../../core/utils/icon_provider.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return SingleChildScrollView(
            padding:
                EdgeInsets.only(bottom: getWidth(context, baseSize: 120) + 15),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    Gap(15),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            _ArticleItem(article: state.articles[index]),
                        separatorBuilder: (BuildContext context, int index) =>
                            Gap(20),
                        itemCount: state.articles.length)
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF00FB),
            ),
          );
        }
      },
    );
  }
}

class _ArticleItem extends StatelessWidget {
  final Articles article;

  const _ArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: () {
        context.push('${RouteValue.articles.path}/${RouteValue.article.path}',
            extra: article);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AppIcon(
            asset: IconProvider.articleButton.buildImageUrl(),
            width: getWidth(context, percent: 1) - 14,
            fit: BoxFit.fitWidth,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
              child: GradientText(
                article.title,
                fontSize: 65,
                isCenter: true,
              )),
          Gap(20),
        ],
      ),
    );
  }
}
