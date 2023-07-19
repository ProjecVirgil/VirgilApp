// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:virgil_app/screen/utils/swtichBrightness.dart';

class frostedGlass extends StatelessWidget {
  const frostedGlass(
      {super.key,
      required this.Width,
      required this.Height,
      required this.child});
  final Width;
  final Height;
  final child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: Width,
        height: Height,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: HexColor(context.watch<brightessSwitch>().text).withOpacity(0.13)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        HexColor(context.watch<brightessSwitch>().text).withOpacity(0.15),
                        HexColor(context.watch<brightessSwitch>().text).withOpacity(0.05),
                      ])),
            ),
            Center(
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
