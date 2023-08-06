// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../utils/swtichBrightness.dart';

class titleSignup extends StatelessWidget {
  const titleSignup({super.key});

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;

    return Stack(children: [
      Positioned(
          top: 90,
          left: 40,
          child: Text('Welcome',
              style: GoogleFonts.ptSans(
                  fontSize: screenWidth / 10, fontWeight: FontWeight.bold,color: HexColor(context.watch<brightessSwitch>().text)))),
      Positioned(
        top: 140,
        left: 40,
        child: Text(
          'Create an account to use Virgil',
          style: GoogleFonts.ptSans(fontSize: screenWidth / 20,color: HexColor(context.watch<brightessSwitch>().text)),
        ),
      ),
    ]);
  }
}
