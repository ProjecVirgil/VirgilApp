import 'package:flutter/material.dart';
import 'package:virgil_app/screen/utils/sideBar.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virgil_app/screen/utils/swtichBrightness.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:virgil_app/screen/utils/frostedGlass.dart';


class configure extends StatefulWidget {
  const configure({super.key});

  @override
  State<configure> createState() => _configureState();
}

class _configureState extends State<configure> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  //KEY FORM
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: HexColor(context.watch<brightessSwitch>().background),
      key: _globalKey,
      drawer: const sideBar(),
      body: Stack(
        children: [ CustomScrollView(
          slivers: [
          SliverAppBar(
          floating: true,
          automaticallyImplyLeading: false,
          title: const Text('Configure'),
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
        ]
     ),

          Form(
            key: formKey ,
            child: Padding(padding: EdgeInsets.only(top:(screenHeight - 300) / 2 ,left: (screenWidth - 350) / 2 ),
            child: frostedGlass(
              Width: 350.0,
              Height: 400.0,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  
                ),
              )

            ),),
          )
    ]
      ),
    );
  }
}
