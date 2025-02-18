import 'package:cleopatras_secrets/src/feature/rituals/bloc/user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../../routes/go_router_config.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(UserLoadData()),
      child: CupertinoApp.router(
        theme: const CupertinoThemeData(
          brightness: Brightness.light,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              fontFamily: 'Bur',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF510202),
            ),
          ),
        ),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 24,
                  color: Color(0xFFFFE5D2),
                ),
              ),
            ),
            child: child!,
          );
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: buildGoRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
