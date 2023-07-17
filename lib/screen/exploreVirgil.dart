// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:virgil_app/screen/utils/sideBar.dart';
import 'package:virgil_app/screen/utils/swtichBrightness.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:virgil_app/screen/utils/cardExplore.dart';

class explore extends StatefulWidget {
  const explore({super.key});

  @override
  State<explore> createState() => _exploreState();
}

class _exploreState extends State<explore> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  List<List<dynamic>> cardList = [
    [
      'Wheather',
      'try say Virgilio che tempo fa a Roma',
      'images/UndrawCard/Weather.png',
      Icons.sunny
    ],
    [
      'Time',
      'try say Virgilio che ore sono',
      'images/UndrawCard/Time.png',
      Icons.access_time
    ],
    [
      'News',
      'try say Virgilio dimmi le ultime notizie',
      'images/UndrawCard/News.png',
      Icons.newspaper
    ],
    [
      'Volume',
      'try say Virgilio imposta il volume al 20%',
      'images/UndrawCard/Volume.png',
      Icons.volume_up
    ],
    [
      'Temperatura',
      'try say Virgilio quanti gradi fanno a Napoli',
      'images/UndrawCard/Temperature.png',
      Icons.sunny_snowing
    ],
    [
      'Days of Week',
      'try say Virgilio che giorno è domani',
      'images/UndrawCard/Calendar.png',
      Icons.calendar_month_outlined
    ],
    [
      'Domotic',
      'try say Virgilio accendi la luce',
      'images/UndrawCard/Domotic.png',
      Icons.lightbulb
    ],
    [
      'Timer',
      'try say Virgilio imposta un timer di 30 secondi',
      'images/UndrawCard/Timer.png',
      Icons.timer
    ],
    [
      'GPT',
      'try say Virgilio speak me of the quantic math',
      'images/UndrawCard/GPT.png',
      Icons.computer
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(context.watch<brightessSwitch>().background),
      key: _globalKey,
      drawer: const sideBar(),
      //BODY
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            automaticallyImplyLeading: false,
            title: const Text('Explore'),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                _globalKey.currentState!.openDrawer();
              },
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child:
                      context.watch<brightessSwitch>().background == '#303030'
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
                color: Colors
                    .deepPurpleAccent, // Imposta il colore del bordo inferiore
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final i = cardList[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20.0, left: 10, right: 10, top: 20),
                  child: cardExplore(
                    title: i[0],
                    subtitle: i[1],
                    pathImage: i[2],
                    icon: i[3],
                  ),
                );
              },
              childCount: cardList.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
/*

 */
