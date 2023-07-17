// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:virgil_app/screen/utils/sideBar.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virgil_app/screen/utils/swtichBrightness.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';

class settingsVirgil extends StatefulWidget {
  const settingsVirgil({super.key});

  @override
  State<settingsVirgil> createState() => _settingsVirgilState();
}

class _settingsVirgilState extends State<settingsVirgil> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String dropdownValue = 'en';
  bool isDynamic = true;
  double valoreSlider = 100;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final subtitle = GoogleFonts.ubuntu(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color:
            HexColor(context.watch<brightessSwitch>().text).withOpacity(0.5));
    final title = GoogleFonts.ubuntu(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: HexColor(context.watch<brightessSwitch>().text));
    final divider = GoogleFonts.ubuntu(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: HexColor(context.watch<brightessSwitch>().text));
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    //double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: HexColor(context.watch<brightessSwitch>().background),
      key: _globalKey,
      drawer: const sideBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            automaticallyImplyLeading: false,
            title: const Text('Setting'),
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
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 18.0),
                  child: Text('General',
                      textAlign: TextAlign.center, style: divider),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Choose language',
                    style: title,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'choose the language for some translations that virgil will do such as weather or temperature translation',
                    style: subtitle,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: (screenWidth - 70) / 2,
                      right: (screenWidth - 86) / 2),
                  child: DropdownButton<String>(
                    iconSize: 20,
                    focusColor: Colors.deepPurple,
                    dropdownColor: Colors.deepPurple,
                    iconEnabledColor:
                        HexColor(context.watch<brightessSwitch>().text),
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['en', 'it', 'fr', 'de', 'es']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child:
                      Text('Choose your Virgil activation word', style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      'it is recommended to use an Italian word for now',
                      style: subtitle),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12,
                      left: (screenWidth - 220) / 2,
                      right: (screenWidth - 220) / 2),
                  child: SizedBox(
                    width: 200,
                    child: TextField(
                      maxLines: 1,
                      maxLength: 10,
                      autocorrect: false,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: 'es: virgilio',
                        hintStyle: TextStyle(
                          color: HexColor(context.watch<brightessSwitch>().text)
                              .withOpacity(0.8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(context
                                  .watch<brightessSwitch>()
                                  .text)), // Colore del bordo quando l'input è abilitato
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Choose the volume", style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      "The choice of volume will be considered only at startup you can change it during execution only from virgil itself ",
                      style: subtitle,
                      textAlign: TextAlign.left),
                ),
                Slider(
                  inactiveColor: Colors.deepPurpleAccent[200],
                  activeColor: Colors.deepPurple,
                  thumbColor: Colors.deepPurpleAccent,
                  divisions: 9,
                  //overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                  secondaryActiveColor:
                      HexColor(context.watch<brightessSwitch>().text),
                  label: valoreSlider.toString(),
                  value: valoreSlider,
                  onChanged: (value) {
                    setState(() {
                      valoreSlider = value;
                    });
                  },
                  min: 10,
                  max: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Choose your City", style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      'The city choice is only for setting a default city when running weather or temperature commands',
                      style: subtitle,
                      textAlign: TextAlign.left),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 8,
                      left: (screenWidth - 200) / 2,
                      right: (screenWidth - 200) / 2),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple)),
                      onPressed: () async {
                        Location location = Location();

                        bool serviceEnabled;
                        PermissionStatus permissionGranted;

                        serviceEnabled = await location.serviceEnabled();
                        if (!serviceEnabled) {
                          serviceEnabled = await location.requestService();
                          if (!serviceEnabled) {
                            return;
                          }
                        }

                        permissionGranted = await location.hasPermission();
                        if (permissionGranted == PermissionStatus.denied) {
                          permissionGranted =
                              await location.requestPermission();
                          if (permissionGranted != PermissionStatus.granted) {
                            return;
                          }
                        }

                        geolocator.Position position =
                            await geolocator.Geolocator.getCurrentPosition();

                        double latitude = position.latitude;
                        double longitude = position.longitude;

                        List<geocoding.Placemark> city = await geocoding
                            .placemarkFromCoordinates(latitude, longitude);
                        //print(city[0].locality);
                      },
                      child: const Text('Take position')),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
                  child: Divider(
                    thickness: 4,
                    color: Colors.deepPurpleAccent.withOpacity(0.5),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: (screenWidth - 130) / 2),
                  child: Text(
                    "Listener",
                    style: divider,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 8.0, left: (screenWidth - 360) / 2),
                  child: Text(
                    'Modify the setting of the microphone when use Virgil',
                    style: subtitle,
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text('Operation timeout', style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('time limit for one expression', style: subtitle),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: (screenWidth - 220) / 2,
                      right: (screenWidth - 220) / 2),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      maxLength: 10,
                      autocorrect: false,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: '3',
                        hintStyle: TextStyle(
                          color: HexColor(context.watch<brightessSwitch>().text)
                              .withOpacity(0.8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(context
                                  .watch<brightessSwitch>()
                                  .text)), // Colore del bordo quando l'input è abilitato
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text('Energy threshold', style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('sensitivity of microphone', style: subtitle),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: (screenWidth - 220) / 2,
                      right: (screenWidth - 220) / 2),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      maxLength: 10,
                      autocorrect: false,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: '3500',
                        hintStyle: TextStyle(
                          color: HexColor(context.watch<brightessSwitch>().text)
                              .withOpacity(0.8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(context
                                  .watch<brightessSwitch>()
                                  .text)), // Colore del bordo quando l'input è abilitato
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text('Energy threshold dynamic', style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('microphone sensitivity set dynamically ',
                      style: subtitle),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: (screenWidth - 80) / 2,
                      right: (screenWidth - 80) / 2),
                  child: Switch(
                    value: isDynamic,
                    onChanged: (bool value) {
                      setState(() {
                        isDynamic = value;
                      });
                    },
                    activeColor: Colors.deepPurpleAccent,
                  ),
                ),
                //DA AGGIUNGERE CHEKBOX TRUE FALSE

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
                  child: Divider(
                    thickness: 4,
                    color: Colors.deepPurpleAccent.withOpacity(0.5),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: (screenWidth - 100) / 2,
                      right: (screenWidth - 100) / 2),
                  child: Text(
                    "API",
                    style: divider,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.0,
                      left: (screenWidth - 380) / 2,
                      right: (screenWidth - 380) / 2),
                  child: Text(
                    'set your API key',
                    style: subtitle,
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text('GPT', style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('API for GPT interaction', style: subtitle),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: (screenWidth - 280) / 2,
                      right: (screenWidth - 280) / 2),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      maxLines: 1,
                      maxLength: 52,
                      autocorrect: false,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: 'key',
                        hintStyle: TextStyle(
                          color: HexColor(context.watch<brightessSwitch>().text)
                              .withOpacity(0.8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(context
                                  .watch<brightessSwitch>()
                                  .text)), // Colore del bordo quando l'input è abilitato
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text('OpenMeteo', style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('API for Wheather interaction', style: subtitle),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: (screenWidth - 280) / 2,
                      right: (screenWidth - 280) / 2),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      maxLines: 1,
                      maxLength: 32,
                      autocorrect: false,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: 'key',
                        hintStyle: TextStyle(
                          color: HexColor(context.watch<brightessSwitch>().text)
                              .withOpacity(0.8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(context
                                  .watch<brightessSwitch>()
                                  .text)), // Colore del bordo quando l'input è abilitato
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text('Merros', style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('API for domotic Merros', style: subtitle),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: (screenWidth - 280) / 2,
                      right: (screenWidth - 280) / 2),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      maxLines: 1,
                      maxLength: 100,
                      autocorrect: false,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: 'email',
                        hintStyle: TextStyle(
                          color: HexColor(context.watch<brightessSwitch>().text)
                              .withOpacity(0.8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(context
                                  .watch<brightessSwitch>()
                                  .text)), // Colore del bordo quando l'input è abilitato
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: (screenWidth - 280) / 2,
                      right: (screenWidth - 280) / 2),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      maxLines: 1,
                      maxLength: 100,
                      autocorrect: false,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: 'password',
                        hintStyle: TextStyle(
                          color: HexColor(context.watch<brightessSwitch>().text)
                              .withOpacity(0.8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(context
                                  .watch<brightessSwitch>()
                                  .text)), // Colore del bordo quando l'input è abilitato
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text('Deeple', style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('API for translate some interaction',
                      style: subtitle),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: (screenWidth - 280) / 2,
                      right: (screenWidth - 280) / 2),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      maxLines: 1,
                      maxLength: 40,
                      autocorrect: false,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: 'key',
                        hintStyle: TextStyle(
                          color: HexColor(context.watch<brightessSwitch>().text)
                              .withOpacity(0.8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(context
                                  .watch<brightessSwitch>()
                                  .text)), // Colore del bordo quando l'input è abilitato
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
                  child: Divider(
                    thickness: 4,
                    color: Colors.deepPurpleAccent.withOpacity(0.5),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: (screenWidth - 100) / 2,
                      right: (screenWidth - 100) / 2),
                  child: Text(
                    "GPT",
                    style: divider,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.0,
                      left: (screenWidth - 270) / 2,
                      right: (screenWidth - 270) / 2),
                  child: Text(
                    'GPT setting',
                    style: subtitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text('Temperature', style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child:
                      Text('handles randomness of responses', style: subtitle),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: (screenWidth - 220) / 2,
                      right: (screenWidth - 220) / 2),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      maxLength: 3,
                      autocorrect: false,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: '0.0 - 2.0',
                        hintStyle: TextStyle(
                          color: HexColor(context.watch<brightessSwitch>().text)
                              .withOpacity(0.8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(context
                                  .watch<brightessSwitch>()
                                  .text)), // Colore del bordo quando l'input è abilitato
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text('Max token', style: title),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      'max lenght responses, the length of the response will cost more in the long run',
                      style: subtitle),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: (screenWidth - 220) / 2,
                      right: (screenWidth - 220) / 2),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      maxLength: 10,
                      autocorrect: false,
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        hintText: '30',
                        hintStyle: TextStyle(
                          color: HexColor(context.watch<brightessSwitch>().text)
                              .withOpacity(0.8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(context
                                  .watch<brightessSwitch>()
                                  .text)), // Colore del bordo quando l'input è abilitato
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
                  child: Divider(
                    thickness: 4,
                    color: Colors.deepPurpleAccent.withOpacity(0.5),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: (screenWidth - 200) / 2,
                      right: (screenWidth - 200) / 2,
                      bottom: 50),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepPurple),
                    ),
                    child: const Text('Default setting'),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}
