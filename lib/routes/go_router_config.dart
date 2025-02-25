import 'package:cleopatras_secrets/src/feature/rituals/model/articles.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/rituals.dart';
import 'package:cleopatras_secrets/src/feature/rituals/screens/article_screen.dart';
import 'package:cleopatras_secrets/src/feature/rituals/screens/articles_screen.dart';
import 'package:cleopatras_secrets/src/feature/rituals/screens/ritual_screen.dart';
import 'package:cleopatras_secrets/src/feature/rituals/screens/rituals_screen.dart';
import 'package:cleopatras_secrets/src/feature/rituals/screens/statistic_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../src/feature/rituals/screens/home_screen.dart';
import '../src/feature/splash/presentation/screens/splash_screen.dart';
import 'root_navigation_screen.dart';
import 'route_value.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildGoRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteValue.splash.path,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          child: RootNavigationScreen(
            navigationShell: navigationShell,
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
                path: RouteValue.home.path,
                builder: (context, state) => HomeScreen(key: UniqueKey()),
                routes: [
                  GoRoute(
                    path: RouteValue.statistic.path,
                    builder: (context, state) =>
                        StatisticScreen(key: UniqueKey()),
                  ),
                ]),
            GoRoute(
                path: RouteValue.articles.path,
                builder: (context, state) => ArticlesScreen(key: UniqueKey()),
                routes: [
                  GoRoute(
                    path: RouteValue.article.path,
                    builder: (context, state) => ArticleScreen(
                        key: UniqueKey(), article: state.extra as Articles),
                  ),
                ]),
            GoRoute(
                path: RouteValue.rituals.path,
                builder: (context, state) => RitualsScreen(key: UniqueKey()),
                routes: [
                  GoRoute(
                    path: RouteValue.ritual.path,
                    builder: (context, state) => RitualScreen(
                        key: UniqueKey(), ritual: state.extra as Rituals),
                  ),
                ]),
          ],
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.black,
            child: child,
          ),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteValue.splash.path,
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
        ),
      ],
    ),
  ],
);
