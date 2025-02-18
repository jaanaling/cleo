import 'package:cleopatras_secrets/src/core/utils/icon_provider.dart';
import 'package:cleopatras_secrets/ui_kit/animated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppAppBar extends StatelessWidget {
  final String title;

  const AppAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(IconProvider.appbar.buildImageUrl()),
          fit: BoxFit.fill,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x99000000),
            blurRadius: 0,
            offset: Offset(0, 6),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedButton(
            onPressed: () {
              context.pop();
            },
            child: Container(
              decoration: ShapeDecoration(
                color: Color(0xFFAFAFAF),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 4, color: Color(0xFF4B4E4B)),
                  borderRadius: BorderRadius.circular(66),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x99000000),
                    blurRadius: 0,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_sharp,
                  color: Color(0xFF383838),
                  weight: 48,
                ),
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          SafeArea(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 50,
                color: Color(0xFFF1F1F1),
                shadows: [
                  BoxShadow(
                    color: Color(0x99000000),
                    blurRadius: 0,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
          ),
          Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
