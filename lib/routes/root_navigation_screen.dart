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
                    IconProvider.background.buildImageUrl(),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          widget.navigationShell,
          Visibility(
            visible: route != '/articles/article',
            child: AnimatedBottomBar(onTap: (index) {
              switch (index) {
                case 0:
                  context.go(RouteValue.home.path);
                case 1:
                  context.go(RouteValue.articles.path);
                case 2:
                  context.go(RouteValue.rituals.path);
              }
            }, index: widget.navigationShell.currentIndex,),
          ),
          if(isAdviceVisible&&route == '/home')
          Stack(
            children: [
              Positioned.fill(
                  child: ColoredBox(color: Colors.black.withOpacity(0.8))),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is! UserLoaded) {
                    return const CupertinoActivityIndicator();
                  }
                  return AdviceScreen(
                      advices: state.advice,
                      onClose: () {
                        setState(() {
                          isAdviceVisible = false;
                        });
                      });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
