import 'package:cleopatras_secrets/src/core/utils/app_icon.dart';
import 'package:cleopatras_secrets/src/core/utils/icon_provider.dart';
import 'package:cleopatras_secrets/src/core/utils/size_utils.dart';
import 'package:cleopatras_secrets/ui_kit/animated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      child: Container(
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [
              Color(0xFFA0FF7E),
              Color(0xFF78FF48),
              Color(0xFF59DD29),
              Color(0xFF32B537)
            ],
          ),
          shape: OvalBorder(
            side: BorderSide(width: 6, color: Color(0xFF3BA43B)),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x99000000),
              blurRadius: 0,
              offset: Offset(0, 13),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppIcon(
            asset: IconProvider.plus.buildImageUrl(),
            width: getWidth(context, percent: 0.15),
          ),
        ),
      ),
    );
  }
}
