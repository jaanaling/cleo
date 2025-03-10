import 'package:cleopatras_secrets/routes/route_value.dart';
import 'package:cleopatras_secrets/ui_kit/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../src/core/utils/icon_provider.dart';
import '../src/feature/rituals/bloc/user_bloc.dart';
import '../src/feature/rituals/screens/home_screen.dart';

bool isAdviceVisible = false;
int gindex = 0;

class RootNavigationScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const RootNavigationScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  State<RootNavigationScreen> createState() => _RootNavigationScreenState();
}

class _RootNavigationScreenState extends State<RootNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    final route = widget.navigationShell.shellRouteContext.routerState.fullPath;

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    route != '/rituals/ritual' && route != '/home/detailed'
                        ? IconProvider.background.buildImageUrl()
                        : IconProvider.bluredBackground.buildImageUrl(),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          widget.navigationShell,
          Visibility(
            visible: route != '/articles/article' &&
                route != '/rituals/ritual' &&
                route != '/home/detailed',
            child: AnimatedBottomBar(
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go(RouteValue.home.path);
                    gindex = 0;

                  case 1:
                    context.go(RouteValue.articles.path);
                    gindex = 1;
                  case 2:
                    context.go(RouteValue.rituals.path);
                    gindex = 2;
                }
              },
              index: gindex,
            ),
          ),
        ],
      ),
    );
  }
}
