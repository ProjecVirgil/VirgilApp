// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class titleLogin extends StatelessWidget {
  const titleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: 90,
          left: 40,
          child: Text('Welcome back',
              style: GoogleFonts.ptSans(
                  fontSize: 40, fontWeight: FontWeight.bold)
          )
      ),
      Positioned(
        top: 140,
        left: 40,
        child: Text(
          'Login with your account to use Virgil',
          style: GoogleFonts.ptSans(fontSize: 20),
        ),
      ),
    ]);
  }
}
