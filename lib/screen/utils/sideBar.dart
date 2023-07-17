
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

  Future<void> esci() async {
    await Auth().signOut();
  }


  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<brightessSwitch>().isDark;
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    //double screenHeight = screenSize.height;

    return  Drawer(
      width: screenWidth / 2,
      backgroundColor: HexColor(context.watch<brightessSwitch>().background),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      child: ListView(
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
            padding: const EdgeInsets.only(top: 30.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'images/Icons/brightnessGrey.png',
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
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
              padding: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/Icons/homeGrey.png',
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
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
              padding: const EdgeInsets.only(top: 30.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/Icons/setting-linesGrey.png',
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
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
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('images/Icons/configurationGrey.png', width: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
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
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'explore');
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/Icons/compassGrey.png',
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
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
          Padding(
            padding: const EdgeInsets.only(top: 380.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('images/Icons/profile.png', width: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Account Setting',
                    style: GoogleFonts.ibmPlexSans(
                        color: HexColor('8a8a8a'),
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('images/Icons/logoutGrey.png', width: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
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
        ],
      ),
    );
  }
}
