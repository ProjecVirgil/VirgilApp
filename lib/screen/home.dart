// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:virgil_app/screen/utils/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virgil_app/screen/utils/cardSetting.dart';
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

  double _height = 0.0;

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
                  child: Image.asset('images/shapeHome.webp', scale: 1.2)),
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
                          fontSize: 40,
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
              Positioned(
                top: screenHeight / 2 - (screenHeight/6),
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  width: screenWidth - 100,
                  height: screenHeight - 100,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 0, right: 16),
                      child: AnimatedDefaultTextStyle(
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: HexColor(
                                context.watch<brightessSwitch>().text)),
                        duration: const Duration(milliseconds: 500),
                        child: const Text(
                            'Hi now that you are in you can configure and set up your Virgilio whenever and wherever you want first I suggest you configure virgilio via the token and then start exploring all you can do '),
                      )),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(-1.0, -1.0),
                      child: Image.asset(
                        'images/shapeHome.webp',
                        scale: 1.2,
                      ))),
              Positioned(
                bottom: 10,
                left: (screenWidth - 50) / 2,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        _height = screenHeight / 2;
                      });
                    },
                    icon: const Icon(Icons.arrow_upward)),
              ),
              Positioned(
                bottom: 0,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                    width: screenWidth,
                    height: _height,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color:
                          HexColor(context.watch<brightessSwitch>().background),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _height = 0;
                              });
                            },
                            icon: const Icon(Icons.arrow_downward),
                            color:
                                HexColor(context.read<brightessSwitch>().text)),
                        const CardSetting(
                          title: 'Explore',
                          icon: 'images/Icons/compass.png',
                          paragraf: 'Find out what Virgil can do',
                          page: 'explore',
                        ),
                        const CardSetting(
                          title: 'Configure',
                          icon: 'images/Icons/configuration.png',
                          paragraf: 'Configure your Virgil with app',
                          page: 'configure',
                        ),
                        const CardSetting(
                          title: 'Virgil setting',
                          icon: 'images/Icons/setting-lines.png',
                          paragraf: 'Modify the setting of your virgil',
                          page: 'settings',
                        ),
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
