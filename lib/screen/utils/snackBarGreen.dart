// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class snackBarGreen extends StatefulWidget {
  const snackBarGreen({super.key});

  @override
  State<snackBarGreen> createState() => _snackBarGreenState();
}

class _snackBarGreenState extends State<snackBarGreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      width: 300,
      backgroundColor: HexColor('12aa15'),
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      animation: CurvedAnimation(
        parent: AnimationController(
            duration: const Duration(milliseconds: 500),
            // Durata dell'animazione
            vsync: this),
        curve: Curves.easeInOutQuart, // Curva dell'animazione);
      ),
      duration: const Duration(seconds: 2),
      content: Text(
        'New setting sent',
        style: GoogleFonts.ubuntu(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Imposta il valore del raggio
      ),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'OK',
        onPressed: () {},
      ),
    );
  }
}
