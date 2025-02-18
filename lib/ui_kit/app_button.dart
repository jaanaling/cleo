import 'package:cleopatras_secrets/ui_kit/animated_button.dart';
import 'package:flutter/cupertino.dart';

List<Color> generateGradientColors(
  Color startColor,
  Color endColor,
  int steps,
) {
  final List<Color> colors = [];
  for (int i = 0; i < steps; i++) {
    final double t = i / (steps - 1); // Нормализуем значение от 0 до 1
    colors.add(Color.lerp(startColor, endColor, t)!);
  }
  return colors;
}

class AppButton extends StatelessWidget {
  final BColor color;
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? fontSize;

  const AppButton({
    super.key,
    required this.color,
    required this.onPressed,
    required this.text,
    this.width,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      child: Container(
        width: width,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: generateGradientColors(color.startColor, color.endColor, 4),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 8, color: Color(color.borderColor.value)),
            borderRadius: BorderRadius.circular(36),
          ),
          shadows: [
            const BoxShadow(
              color: Color(0x99000000),
              blurRadius: 0,
              offset: Offset(0, 3),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
          child: Text(
            text,
            style: TextStyle(
              color: Color(color.textColor.value),
              fontSize: fontSize ?? 30,
              fontFamily: 'Bur',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

enum BColor {
  green(
    startColor: Color(0xFF73FF40),
    endColor: Color(0xFF06B60C),
    borderColor: Color(0xFF3BA43B),
    textColor: Color(0xFF007300),
  ),
  yellow(
    startColor: Color(0xFFFFEF40),
    endColor: Color(0xFFB67306),
    borderColor: Color(0xFFF3973B),
    textColor: Color(0xFF732200),
  ),

  red(
    startColor: Color(0xFFFF7B5A),
    endColor: Color(0xFF9A0C07),
    borderColor: Color(0xFFA11A1A),
    textColor: Color(0xFF67180A),
  ),
  blue(
    startColor: Color(0xFF4EBBFF),
    endColor: Color(0xFF326BB5),
    borderColor: Color(0xFF3B59A4),
    textColor: Color(0xFF221567),
  );

  final Color startColor;
  final Color endColor;
  final Color borderColor;
  final Color textColor;
  const BColor({
    required this.startColor,
    required this.endColor,
    required this.borderColor,
    required this.textColor,
  });
}
