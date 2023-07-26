// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:virgil_app/screen/utils/auth.dart';
import 'package:virgil_app/screen/utils/swtichBrightness.dart';

class sideBar extends StatefulWidget {
  const sideBar({super.key});

  @override
  State<sideBar> createState() => _sideBarState();




}

class _sideBarState extends State<sideBar> {

  final double SPACE_ORZ=50;
  final double Icon_SIZE = 25;
  final double SPACE_VER = 13;
  Future<void> esci() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<brightessSwitch>().isDark;
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return Drawer(
      width: screenWidth / 2,
      backgroundColor: HexColor(context.watch<brightessSwitch>().background),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      child: SizedBox.expand(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/IconsLogo.png', width: 40),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 30,
                          child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..scale(-1.0, 1.0),
                              child: Image.asset('images/Icons/menus.png')),
                        ),
                      ),
                    )),
              ],
            ),

            Padding(
              padding:  EdgeInsets.only(top: SPACE_ORZ, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/Icons/brightnessGrey.png',
                    width: Icon_SIZE,
                  ),
                  Padding(
                    padding:EdgeInsets.only(left: SPACE_VER),
                    child: Switch(
                      value: isDark,
                      onChanged: (bool value) {
                        setState(() {
                          isDark = value;
                        });
                        if (isDark) {
                          context.read<brightessSwitch>().switchDark();
                        } else {
                          context.read<brightessSwitch>().switchLight();
                        }
                      },
                      activeColor: Colors.deepPurpleAccent,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'home');
              },
              child: Padding(
                padding:  EdgeInsets.only(top: SPACE_ORZ, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/Icons/homeGrey.png',
                      width: Icon_SIZE,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: SPACE_VER),
                      child: Text(
                        'Home',
                        style: GoogleFonts.ibmPlexSans(
                            color: HexColor('8a8a8a'),
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'settings');
              },
              child: Padding(
                padding:  EdgeInsets.only(top: SPACE_ORZ, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/Icons/setting-linesGrey.png',
                      width: Icon_SIZE,
                    ),
                    Padding(
                      padding:EdgeInsets.only(left: SPACE_VER),
                      child: Text(
                        'Virgil setting',
                        style: GoogleFonts.ibmPlexSans(
                            color: HexColor('8a8a8a'),
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'configure');
              },
              child: Padding(
                padding:  EdgeInsets.only(top: SPACE_ORZ, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('images/Icons/configurationGrey.png', width: Icon_SIZE),
                    Padding(
                      padding:EdgeInsets.only(left: SPACE_VER),
                      child: Text(
                        'Configure',
                        style: GoogleFonts.ibmPlexSans(
                            color: HexColor('8a8a8a'),
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'explore');
              },
              child: Padding(
                padding:  EdgeInsets.only(top: SPACE_ORZ, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/Icons/compassGrey.png',
                      width: Icon_SIZE,
                    ),
                    Padding(
                      padding:EdgeInsets.only(left: SPACE_VER),
                      child: Text(
                        'Explore Virgil',
                        style: GoogleFonts.ibmPlexSans(
                            color: HexColor('8a8a8a'),
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'settingAcc');
              },
              child: Padding(
                padding:  EdgeInsets.only(top: SPACE_ORZ, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('images/Icons/profile.png', width: Icon_SIZE),
                    Padding(
                      padding:EdgeInsets.only(left: SPACE_VER),
                      child: Text(
                        'Account',
                        style: GoogleFonts.ibmPlexSans(
                            color: HexColor('8a8a8a'),
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight - 650),
            GestureDetector(
              onTap: () {
                esci();
              },
              child: Padding(
                padding:  const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('images/Icons/logoutGrey.png', width: Icon_SIZE),
                    Padding(
                      padding:EdgeInsets.only(left: SPACE_VER),
                      child: TextButton(
                          onPressed: () {
                            esci();
                          },
                          child: Text(
                            'Logout',
                            style: GoogleFonts.ibmPlexSans(
                                color: HexColor('8a8a8a'),
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}