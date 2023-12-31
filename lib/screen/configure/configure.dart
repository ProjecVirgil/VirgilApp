// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:virgil_app/screen/utils/sideBar.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virgil_app/screen/utils/swtichBrightness.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:virgil_app/screen/utils/frostedGlass.dart';
import 'package:virgil_app/screen/configure/formKey.dart';

class configure extends StatefulWidget {
  const configure({super.key});

  @override
  State<configure> createState() => _configureState();
}

class _configureState extends State<configure> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      // Aggiorna lo stato di focus
      focus = _focusNode.hasFocus;
      if (focus) {
        _opacity = 0;
      } else {
        _opacity = 1;
      }
    });
  }

  bool focus = false;
  double _opacity = 1.0;

  void _handleScreenTap() {
    // Rimuovi il focus dagli elementi di input
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return GestureDetector(
      onTap: _handleScreenTap,
      child: Scaffold(
        key: _globalKey,
        drawer: const sideBar(),
        body: AnimatedContainer(
          color: HexColor(context.watch<brightessSwitch>().background),
          duration: const Duration(seconds: 1),
          child: Stack(children: [
            Positioned(
                //top: -60,
                top: 20,
                child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(-1.0, -1.0),
                    child: Image.asset('images/shapeConfigure.png',scale: 2.0,))),
            Positioned(
                //bottom: -60,
                bottom: 0,
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _opacity,
                    child: Image.asset('images/shapeConfigure.png',scale: 2.0,))),
            CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
              SliverAppBar(
                floating: true,
                automaticallyImplyLeading: false,
                title: AnimatedDefaultTextStyle(
                    style: GoogleFonts.ubuntu(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor(context.watch<brightessSwitch>().text)),
                    duration: const Duration(milliseconds: 1000),
                    child: const Text('Configure')),
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    _globalKey.currentState!.openDrawer();
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child:
                      context.watch<brightessSwitch>().background == '#1d1e27'
                              ? Image.asset('images/Icons/menusWhite.png')
                              : Image.asset('images/Icons/menusBlack.png')),
                ),
                elevation: 0,
                backgroundColor:
                    HexColor(context.watch<brightessSwitch>().background),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1.0),
                  // Imposta l'altezza del bordo inferiore
                  child: Container(
                    height: 1,
                    color: HexColor("#A58EF5"), // Imposta il colore del bordo inferiore
                  ),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.only(
                  top: (screenHeight - 300) / 2, left: (screenWidth - 350) / 2),
              child: GestureDetector(
                  onTap: () {
                    // Rimuovi il focus dagli elementi di input
                    _focusNode.unfocus();
                  },
                  child: frostedGlass(
                      Width: 350.0,
                      Height: 400.0,
                      child: FocusScope(
                          child: Focus(
                              focusNode: _focusNode, child: const formKey())))),
            ),
          ]),
        ),
      ),
    );
  }
}
