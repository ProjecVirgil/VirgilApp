// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:virgil_app/screen/utils/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virgil_app/screen/utils/cardSetting.dart';
import 'package:virgil_app/screen/utils/fixedBehavior.dart';
import 'package:virgil_app/screen/utils/sideBar.dart';
import 'package:virgil_app/screen/utils/swtichBrightness.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String user() {
    return Auth().getCurrentUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    String email = user();
    List<String> sliceEmail = email.split('@');
    return Scaffold(
        key: _globalKey,
        drawer: const sideBar(),
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: HexColor(context.watch<brightessSwitch>().background),
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  child: SizedBox(
                      width: screenWidth,
                      child: Image.asset('images/imgAI3-transformed.png', scale: 1))),
              Positioned(
                  top: 45,
                  left: 5,
                  child: GestureDetector(
                    onTap: () {
                      _globalKey.currentState!.openDrawer();
                    },
                    child: SizedBox(
                      width: 30,
                      child: Image.asset('images/Icons/menusWhite.png'),
                    ),
                  )),
              Positioned(
                top: 90,
                left: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(sliceEmail[0],
                      style: GoogleFonts.ptSans(
                          fontSize: screenWidth/10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
              Positioned(
                top: 135,
                left: 15,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('welcome to Virgil App',
                      style: GoogleFonts.ptSans(
                          fontSize: screenWidth/20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
              Positioned(
                top: screenHeight /2.15,
                left:  20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedDefaultTextStyle(
                      style: GoogleFonts.ptSans(
                          fontSize: screenWidth/12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                          duration: const Duration(milliseconds: 500),
                          child: const Text('START FROM THIS')),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                    width: screenWidth,
                    height: screenHeight / 2.15,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView(
                        padding: const EdgeInsets.all(0),
                        children: const [
                          CardSetting(
                            title: 'Explore',
                            icon: 'images/Icons/compass.png',
                            paragraf: 'Find out what Virgil can do',
                            page: 'explore',
                          ),
                          CardSetting(
                            title: 'Configure',
                            icon: 'images/Icons/configuration.png',
                            paragraf: 'Configure your Virgil with app',
                            page: 'configure',
                          ),
                          CardSetting(
                            title: 'Virgil setting',
                            icon: 'images/Icons/setting-lines.png',
                            paragraf: 'Modify the setting of your virgil',
                            page: 'settings',
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
