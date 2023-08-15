// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virgil_app/explore/pageCard.dart';
import 'package:virgil_app/screen/utils/fixedBehavior.dart';
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
      'GPT',
      'try say Virgilio speak me of the quantic math',
      'images/UndrawCard/GPT.png',
      Icons.computer
    ],
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

  ];


  List<List<dynamic>> pageCardList = [
    [
      'GPT',
      "Virgil can do a lot of other things like playing music and reminding you of your daily schedule but if that is not enough don't worry thanks to artificial intelligence you can ask Virgil anything that is missing and you can have more natural and pleasant conversation",
      'images/UndrawCard/GPT.png',
      Icons.computer
    ],
    [
      'Wheather',
      'Hi you know Virgil can tell you what the weather is today and what the weather will be the next 7 days  \n\n • Try saying Virgilio che tempo fa \n • Try Virgilio che tempo fa domani \n •  Try Virgilio che tempo fa il 18',
      'images/UndrawCard/Weather.png',
      Icons.sunny
    ],
    [
      'Time',
      'Hi you know Virgilo can tell you what time it is, but also what day it is and what day of the week it will be tomorrow \n\n • Try saying Virgil what time it is \n • Try saying Virgil how long until 4 o clock',
      'images/UndrawCard/Time.png',
      Icons.access_time
    ],
    [
      'News',
      'You know Virigilio can tell you the latest news in the world \n\n • Try saying Virgil tell me the latest news  \n • Try saying Virgil tell me latest crypto news \n •  Try saying Virgil tell me latest news about Ukraina ',
      'images/UndrawCard/News.png',
      Icons.newspaper
    ],
    [
      'Volume',
      'Virgil can adjust its volume to your liking \n\n • Try saying Virgilio set the volume to 40%\n •  Try saying Virgil sets the volume to 20 ',
      'images/UndrawCard/Volume.png',
      Icons.volume_up
    ],
    [
      'Days of Week',
      'Hi you know Virgil can also tell you what day of the week it is \n\n • Try saying Virgil what day it is\n •  Try saying Virgil what day is tomorrow \n•  Try saying Virgil what day is August 12.',
      'images/UndrawCard/Calendar.png',
      Icons.calendar_month_outlined
    ],
    [
      'Domotic',
      'Did you know that Virgil can also use your home automation \n\n • Try saying Virgil turn on the Light',
      'images/UndrawCard/Domotic.png',
      Icons.lightbulb
    ],
    [
      'Timer',
      'Virgil besides knowing the time can also set timers and alarm clocks for you \n\n • Try saying Virgil sets an alarm for tomorrow at 2:10 p.m.\n •  Try saying Virgil sets a 10-second timer.',
      'images/UndrawCard/Timer.png',
      Icons.timer
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: const sideBar(),
      //BODY
      body: AnimatedContainer(
        color: HexColor(context.watch<brightessSwitch>().background),
        duration: const Duration(seconds: 1),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                automaticallyImplyLeading: false,
                title: AnimatedDefaultTextStyle(
                    style: GoogleFonts.ubuntu(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor(context.watch<brightessSwitch>().text)),
                    duration: const Duration(milliseconds: 500),
                    child: const Text('Explore')),
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    _globalKey.currentState!.openDrawer();
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child:
                          context.watch<brightessSwitch>().background == '#121212'
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
                    color: HexColor("#4b008e"), // Imposta il colore del bordo inferiore
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final i = cardList[index];
                    final j = pageCardList[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, left: 10, right: 10, top: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'pageCardExplore',arguments: PageCard(
                            title: j[0],
                            text: j[1],
                            pathImage: j[2],
                            icon: j[3],
                          ),);
                        },
                        child: cardExplore(
                          title: i[0],
                          subtitle: i[1],
                          pathImage: i[2],
                          icon: i[3],
                        ),
                      ),
                    );
                  },
                  childCount: cardList.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor("#290043"),
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
