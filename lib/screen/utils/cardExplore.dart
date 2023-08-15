// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class cardExplore extends StatelessWidget {
  const cardExplore(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.pathImage,
      required this.icon});

  final IconData icon;
  final String title;
  final String subtitle;
  final String pathImage;

  final double _heightCard = 200.0;
  final double _widthCard = 400.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _widthCard,
      height: _heightCard,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: HexColor("#290043").withOpacity(1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(
                2, 2), // Cambia l'offset per regolare la posizione dell'ombra
          ),
        ],
        border: Border.all(
          color: HexColor("#290043"),
          width: 2,
        ),
        color: HexColor("#290043"),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:Hero(tag: "img$title", child:Image.asset(
              pathImage,
              fit: BoxFit.cover,
              height: _heightCard,
            ))),
        Align(
          alignment: FractionalOffset.bottomRight,
          child: Container(
            width: _widthCard / 1.5,
            height: _heightCard / 2.5,
            decoration: BoxDecoration(
              color: HexColor("#290043"),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, top: 13),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.ptSans(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(icon),
                      )
                    ],
                  ),
                  Positioned(
                    top: 30,
                    child: SizedBox(
                      width: 230,
                      height: 100,
                      child: Text(
                        subtitle,
                        style: GoogleFonts.ubuntu(
                            fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
