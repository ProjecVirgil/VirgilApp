import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CardSetting extends StatelessWidget {
  const CardSetting(
      {super.key,
      required this.title,
      required this.icon,
      required this.paragraf,
      required this.page});

  final String title;
  final String icon;
  final String paragraf;
  final String page;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    //double screenHeight = screenSize.height;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 15,bottom: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, page);
        },
        child: SizedBox(
          height: 100,
          child: Card(
            color: HexColor("#290043"), //4b008e
            shadowColor: HexColor("#4b008e"),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10),
                    child: Image.asset(
                      icon,
                      width: screenWidth / 8,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 100,
                  child: Text(
                    title,
                    style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),

                Positioned(
                  top: 16,
                  right: 20,
                  child: Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 15),
                        child: Text(
                          paragraf,
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      )),
                ),
                // Positioned(child: Icon(Icons.settings)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
