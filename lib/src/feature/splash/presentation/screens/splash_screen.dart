import 'package:advertising_id/advertising_id.dart';
import 'package:cleopatras_secrets/src/core/utils/size_utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../routes/route_value.dart';
import '../../../../core/utils/app_icon.dart';
import '../../../../core/utils/icon_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startLoading(context);
  }

  Future<void> startLoading(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final adId = await AdvertisingId.id(true);
    context.go(RouteValue.home.path);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
            child: AppIcon(asset: IconProvider.splash.buildImageUrl(), width: double.infinity, fit: BoxFit.fitWidth,)),
        Positioned(
          left: getWidth(context, baseSize: 9),
          bottom: getHeight(context, baseSize: 165),
          child: AppIcon(
            asset: IconProvider.logo.buildImageUrl(),
            fit: BoxFit.fitWidth,
            width: getWidth(context, baseSize: 281),
          ),
        ),
        Positioned(
          bottom: getHeight(context, baseSize: 64),
          child: SizedBox(
            width: 297,
            height: 15,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AppIcon(
                  asset: IconProvider.loaderBack.buildImageUrl(),
                  fit: BoxFit.fitWidth,
                  width: 297,
                  height: 15,
                ),
                SizedBox(
                  width: 293,
                  child: LinearProgressIndicator(
                    minHeight: 9.52,
                    backgroundColor: Colors.transparent,
                    color: Color(0xFF55B521),
                    borderRadius: BorderRadius.circular(18),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
