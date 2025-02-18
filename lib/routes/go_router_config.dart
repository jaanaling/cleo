import 'package:cleopatras_secrets/src/feature/rituals/model/chicken.dart';
import 'package:cleopatras_secrets/src/feature/rituals/model/coop.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                  path: RouteValue.detailed.path,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: DetailedScreen(
                      key: UniqueKey(),
                      coop: state.extra! as Coop,
                    ),
                  ),
                  routes: [
                    GoRoute(
                        path: RouteValue.task.path,
                        pageBuilder: (context, state) => NoTransitionPage(
                              child: TasksScreen(
                                coop: state.extra as Coop,
                                key: UniqueKey(),
                              ),
                            ),
                        routes: [
                          GoRoute(
                            path: RouteValue.history.path,
                            pageBuilder: (context, state) => NoTransitionPage(
                              child: HistoryScreen(
                                coop: state.extra as Coop,
                                key: UniqueKey(),
                              ),
                            ),
                          ),
                        ]),
                    GoRoute(
                      path: RouteValue.chicken.path,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: ChickenScreen(
                          idEdit: state.extra as Coop,


                          key: UniqueKey(),
                        ),
                      ),
                    ),
                    GoRoute(
                      path: RouteValue.create.path,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: CreateScreen(
                          key: UniqueKey(),
                          coop: state.extra! as Coop,
                        ),
                      ),
                      routes: [
                        GoRoute(
                          path: RouteValue.chicken.path,
                          pageBuilder: (context, state) => NoTransitionPage(
                            child: ChickenScreen(
                              key: UniqueKey(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GoRoute(
                  path: RouteValue.create.path,
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: CreateScreen(
                      key: UniqueKey(),
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: RouteValue.chicken.path,
                      pageBuilder: (context, state) => NoTransitionPage(
                        child: ChickenScreen(
                          key: UniqueKey(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
