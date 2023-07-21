// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:virgil_app/screen/utils/sideBar.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virgil_app/screen/utils/swtichBrightness.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:virgil_app/screen/utils/auth.dart';

class settingAcc extends StatefulWidget {
  const settingAcc({super.key});

  @override
  State<settingAcc> createState() => _settingAccState();
}

class _settingAccState extends State<settingAcc> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String user() {
    return Auth().getCurrentUserEmail();
  }

  void reset() async {
    await Auth().resetPassword();
  }

  Future<void> verify() async {
    String verificationResult = await Auth().verifyUser();
    setState(() {
      result = verificationResult;
      verifySended = true;
    });
  }

  bool resetSended = false;
  bool verifySended = false;
  String result = '';

  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;
    //double screenWidth = screenSize.width;
    //double screenHeight = screenSize.height;
    String email = user();

    final text = GoogleFonts.ubuntu(
        fontSize: 21,
        fontWeight: FontWeight.normal,
        color: HexColor(context.watch<brightessSwitch>().text).withOpacity(1));

    final checkerVisible = GoogleFonts.ubuntu(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color:
            HexColor(context.watch<brightessSwitch>().text).withOpacity(0.5));

    final checkerInvisible = GoogleFonts.ubuntu(
        color: HexColor(context.watch<brightessSwitch>().text).withOpacity(0));

    return Scaffold(
      backgroundColor: HexColor(context.watch<brightessSwitch>().background),
      key: _globalKey,
      drawer: const sideBar(),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          floating: true,
          automaticallyImplyLeading: false,
          title: AnimatedDefaultTextStyle(
              style: GoogleFonts.ubuntu(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: HexColor(context.watch<brightessSwitch>().text)),
              duration: const Duration(milliseconds: 500),
              child: const Text('Account setting')),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              _globalKey.currentState!.openDrawer();
            },
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: context.watch<brightessSwitch>().background == '#303030'
                    ? Image.asset('images/Icons/menusWhite.png')
                    : Image.asset('images/Icons/menusBlack.png')),
          ),
          elevation: 0,
          backgroundColor:
              HexColor(context.watch<brightessSwitch>().background),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1,
              color: Colors
                  .deepPurpleAccent, // Imposta il colore del bordo inferiore
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Email: $email',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold, fontSize: 21),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepPurple)),
                  onPressed: () {
                    setState(() {
                      resetSended = true;
                    });
                    reset();
                  },
                  child: Text(
                    'Reset password',
                    style: text,
                  )),
            ),
            Center(
                child: Text('email sended check your poste',
                    style: resetSended ? checkerVisible : checkerInvisible)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepPurple)),
                  onPressed: () {
                    verify();
                    setState(() {
                      verifySended = true;
                    });
                  },
                  child: Text(
                    'Verify email',
                    style: text,
                  )),
            ),
            Center(
                child: Text(result.toString(),
                    style: verifySended ? checkerVisible : checkerInvisible)),
          ]),
        ),
      ]),
    );
  }
}
