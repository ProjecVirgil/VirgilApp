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


  Widget _loadImage(String imagePath, double screenWidth) {
    if (Uri.parse(imagePath).isAbsolute) {
      // Se il percorso è un URL, usa Image.network
      return Image.network(
        imagePath,
        width: screenWidth / 8,
      );
    } else {
      // Altrimenti, usa Image.asset
      return Image.asset(
        imagePath,
        width: screenWidth / 8,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    //double screenHeight = screenSize.height;
    double paddingX = screenWidth/30;
    double paddingY = screenHeight/60;
    return Padding(
      padding:  EdgeInsets.only(left: paddingX,right: paddingX,top: paddingY,bottom: paddingY),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, page);
        },
        child: SizedBox(
          height: 100,
          child: Card(
            color: HexColor("#282936"), //4b008e
            shadowColor: HexColor("#333544"),
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
                    child: _loadImage(icon,screenWidth)
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
                        color: HexColor("#DDDDDF")),
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
                              color: HexColor("#DDDDDF")),
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
