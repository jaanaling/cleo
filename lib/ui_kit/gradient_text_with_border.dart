import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final bool isCenter;
  final double fontSize;
  final String? fontFamily;
  const GradientText(
    this.text, {
    this.isCenter = false,
    this.fontSize = 30,
    super.key,
    this.fontFamily,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColor = [Color(0xFFFFDAA6), Color(0xFFFFC370)];
    final Color borderColor = Color(0xFF500101);
    final gradient = LinearGradient(
      colors: gradientColor,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Text(
            text,
            textAlign: isCenter ? TextAlign.center : null,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              letterSpacing: 2.5,
              fontFamily: fontFamily ?? 'Florida Vibes',
              height: 0.65,
              foreground:
                  Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = borderColor,
            ),
          ),
        ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback:
              (bounds) => gradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            text,
            textAlign: isCenter ? TextAlign.center : null,
            style: TextStyle(
              color: gradientColor.first,
              fontSize: fontSize,
              height: 0.65,
              letterSpacing: 2.5,
              fontFamily: fontFamily ?? 'Florida Vibes',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
