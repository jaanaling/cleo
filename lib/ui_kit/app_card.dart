import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  const AppCard({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          gradient: const RadialGradient(
            center: Alignment(0, 1),
            radius: 0,
            colors: [Colors.white, Color(0xFFFFF0D4)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: [
            const BoxShadow(
              color: Color(0x7F000000),
              blurRadius: 0,
           offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: child,
        ),
      ),
    );
  }
}
