import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../screen/utils/fixedBehavior.dart';
import '../screen/utils/sideBar.dart';
import '../screen/utils/swtichBrightness.dart';

class PageCard extends StatelessWidget {
   PageCard(
      {super.key,
      required this.title,
      required this.text,
      required this.pathImage,
      required this.icon});

  final IconData icon;
  final String title;
  final String text;
  final String pathImage;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Scaffold(
      key: _globalKey,
      drawer: const sideBar(),
      body: AnimatedContainer(
          color: HexColor(context.watch<brightessSwitch>().background),
          duration: const Duration(seconds: 1),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: CustomScrollView(controller: _scrollController, slivers: [
              SliverAppBar(
                floating: true,
                automaticallyImplyLeading: false,
                title: AnimatedDefaultTextStyle(
                    style: GoogleFonts.ubuntu(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor(context.watch<brightessSwitch>().text)),
                    duration: const Duration(milliseconds: 500),
                    child: const Text("Discover")),
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    _globalKey.currentState!.openDrawer();
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: context.watch<brightessSwitch>().background ==
                              '#1d1e27'
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
                    color: HexColor(
                        "#333544"), // Imposta il colore del bordo inferiore
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 400,
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      clipBehavior: Clip.hardEdge,
                      color: HexColor("#282936"),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: "img$title",
                            child: Image.asset(
                              pathImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10,top: 15),
                              child: Text(title,style: GoogleFonts.ubuntu(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                          ),),
                          Padding(
                            padding:  const EdgeInsets.only(left: 10,top: 10,right: 10),
                            child: Text(text,style: GoogleFonts.ubuntu(
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
