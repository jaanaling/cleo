import 'package:cleopatras_secrets/routes/root_navigation_screen.dart';
import 'package:cleopatras_secrets/routes/route_value.dart';
import 'package:cleopatras_secrets/src/core/utils/app_icon.dart';
import 'package:cleopatras_secrets/src/core/utils/icon_provider.dart';
import 'package:cleopatras_secrets/src/core/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'animated_button.dart';

class AnimatedBottomBar extends StatefulWidget {
  final void Function(int) onTap;
  final int index;

  const AnimatedBottomBar(
      {super.key, required this.onTap, required this.index});
  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> {

int selectedIndex = 0;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.index;
  }

  void _onItemTapped(int index) {
    setState(() {
    widget.onTap(index);   
    selectedIndex = index;
     });
    
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: AppIcon(
            asset: IconProvider.bottomBarBack.buildImageUrl(),
            width: getWidth(context, baseSize: 338),
            fit: BoxFit.fitWidth,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(IconProvider.home.buildImageUrl(), 0),
            _buildNavItem(IconProvider.articles.buildImageUrl(), 1),
            _buildNavItem(IconProvider.dailyRituals.buildImageUrl(), 2),
          ],
        ),
      ],
    );
  }

  Widget _buildNavItem(String iconPath, int index) {
    return AnimatedButton(
      onPressed: () => _onItemTapped(index),
      child: SizedBox(
        width: getWidth(context, baseSize: 120),
        height: getWidth(context, baseSize: 120),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: selectedIndex == index,
              child: AppIcon(
                asset: IconProvider.bottomBarSelected.buildImageUrl(),
                width: getWidth(context, baseSize: 120),
                height: getWidth(context, baseSize: 120),
              ),
            ),
            AppIcon(
              asset: iconPath,
              width: getHeight(context, baseSize: index == 0 ? 55 : 70),
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }
}
