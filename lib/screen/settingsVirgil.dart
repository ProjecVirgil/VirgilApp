// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:virgil_app/screen/utils/sideBar.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virgil_app/screen/utils/swtichBrightness.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../RouteGenerator.dart';

class settingsVirgil extends StatefulWidget {
  const settingsVirgil({super.key});

  @override
  State<settingsVirgil> createState() => _settingsVirgilState();
}

class _settingsVirgilState extends State<settingsVirgil>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  //KEY FORM
  final formKey = GlobalKey<FormState>();
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  final ScrollController _scrollController = ScrollController();

  //CONTROLLER TEXT
  final TextEditingController _word = TextEditingController();
  final TextEditingController _timeout = TextEditingController();
  final TextEditingController _energy = TextEditingController();
  final TextEditingController _GPT = TextEditingController();
  final TextEditingController _merrosEmail = TextEditingController();
  final TextEditingController _merrosPassord = TextEditingController();
  final TextEditingController _deeple = TextEditingController();
  final TextEditingController _temperature = TextEditingController();
  final TextEditingController _maxtoken = TextEditingController();
  final TextEditingController _meteo = TextEditingController();

  //VALORI SETING
  String language = 'en';
  bool isDynamic = true;
  double volume = 100;
  List<geocoding.Placemark> _city = [];

  //REGEX
  RegExp regexForWord = RegExp(r'^[a-zA-Z0-9\-]+$');
  RegExp regexForGPT = RegExp(r'^[a-zA-Z0-9\-]{51}$');
  RegExp regexWheather = RegExp(r'^[0-9A-Fa-f]{32}$');
  RegExp regexDeeple = RegExp(r'^[a-z0-9:-]{39}$');

  Future<String> readKeyFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/key.txt';
    File file = File(filePath);
    var id = await file.readAsString();
    return id;
  }

  sendNewSetting() async {
    var id = await readKeyFile();
    String url =
        'https://flask-production-bb00.up.railway.app/api/setting/modify/$id/';
    var headers = {
      'Content-Type': 'application/json',
      // Imposta l'intestazione 'Content-Type' a 'application/json'
    };

    dynamic settingUpdate = {
      "language": language,
      "wordActivation": _word.text,
      "volume": volume.toString(),
      "city": _city.isNotEmpty &&
              _city[0].locality != null &&
              _city[0].locality != ''
          ? _city[0].locality
          : 'Salerno',
      "Listener": {
        "operation_timeout": _timeout.text.toString(),
        "dynamic_energy_threshold": isDynamic.toString(),
        "energy_threshold": _energy.text.toString(),
      },
      "api": {
        "openAI": _GPT.text,
        "weather": _meteo.text,
        "merros": [_merrosEmail.text, _merrosPassord.text],
        "deeple": _deeple.text,
      },
      "GPT": {
        "temperature": _temperature.text.toString(),
        "max_tokens": _maxtoken.text.toString(),
      }
    };
    await http.post(
      Uri.parse(url),
      body: jsonEncode(settingUpdate),
      headers: headers,
    );
  }

  // Resto del tuo codice...
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
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute, //DINAMICO
      scaffoldMessengerKey: _messengerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        backgroundColor: HexColor(context.watch<brightessSwitch>().background),
        key: _globalKey,
        drawer: const sideBar(),
        body: CustomScrollView(
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
                  child: const Text('Setting')),
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
              sliver: Form(
                key: formKey,
                child: SliverList(
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
                        value: language,
                        onChanged: (String? newValue) {
                          setState(() {
                            language = newValue!;
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
                      child: Text('Choose your Virgil activation word',
                          style: title),
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
                        child: TextFormField(
                          controller: _word,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !regexForWord.hasMatch(value)) {
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                              return 'non puoi inserire questa stringa';
                            }
                            return null;
                          },
                          maxLines: 1,
                          maxLength: 10,
                          autocorrect: false,
                          cursorColor: Colors.deepPurple,
                          decoration: InputDecoration(
                            hintText: 'es: virgilio',
                            hintStyle: TextStyle(
                              color: HexColor(
                                      context.watch<brightessSwitch>().text)
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
                      label: volume.toString(),
                      value: volume,
                      onChanged: (value) {
                        setState(() {
                          volume = value;
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
                              if (permissionGranted !=
                                  PermissionStatus.granted) {
                                return;
                              }
                            }

                            geolocator.Position position = await geolocator
                                .Geolocator.getCurrentPosition();

                            double latitude = position.latitude;
                            double longitude = position.longitude;
                            _city = await geocoding.placemarkFromCoordinates(
                                latitude, longitude);
                            //print(city[0].locality);
                          },
                          child: const Text('Take position')),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 5),
                      child: Divider(
                        thickness: 4,
                        color: Colors.deepPurpleAccent.withOpacity(0.5),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Listener",
                        style: divider,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, left: (screenWidth - 360) / 2),
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
                      child: Text('time limit for one expression',
                          style: subtitle),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SizedBox(
                          width: 150,
                          child: TextField(
                            controller: _timeout,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            maxLength: 10,
                            autocorrect: false,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                              hintText: '3',
                              hintStyle: TextStyle(
                                color: HexColor(
                                        context.watch<brightessSwitch>().text)
                                    .withOpacity(0.8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor(context
                                        .watch<brightessSwitch>()
                                        .text)), // Colore del bordo quando l'input è abilitato
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SizedBox(
                          width: 150,
                          child: TextField(
                            controller: _energy,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            maxLength: 10,
                            autocorrect: false,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                              hintText: '3500',
                              hintStyle: TextStyle(
                                color: HexColor(
                                        context.watch<brightessSwitch>().text)
                                    .withOpacity(0.8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor(context
                                        .watch<brightessSwitch>()
                                        .text)), // Colore del bordo quando l'input è abilitato
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 5),
                      child: Divider(
                        thickness: 4,
                        color: Colors.deepPurpleAccent.withOpacity(0.5),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text(
                          "API",
                          style: divider,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text(
                          'set your API key',
                          style: subtitle,
                          textAlign: TextAlign.center,
                        ),
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _GPT,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !regexForGPT.hasMatch(value)) {
                                _scrollController.animateTo(
                                  1200,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                                return 'inserisci una key valida';
                              }
                              return null;
                            },
                            maxLines: 1,
                            maxLength: 51,
                            autocorrect: false,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                              hintText: 'key',
                              hintStyle: TextStyle(
                                color: HexColor(
                                        context.watch<brightessSwitch>().text)
                                    .withOpacity(0.8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor(context
                                        .watch<brightessSwitch>()
                                        .text)), // Colore del bordo quando l'input è abilitato
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
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
                      child:
                          Text('API for Wheather interaction', style: subtitle),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _meteo,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !regexWheather.hasMatch(value)) {
                                _scrollController.animateTo(
                                  1200,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                                return 'inserisci una key valida';
                              }
                              return null;
                            },
                            maxLines: 1,
                            maxLength: 32,
                            autocorrect: false,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                              hintText: 'key',
                              hintStyle: TextStyle(
                                color: HexColor(
                                        context.watch<brightessSwitch>().text)
                                    .withOpacity(0.8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor(context
                                        .watch<brightessSwitch>()
                                        .text)), // Colore del bordo quando l'input è abilitato
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SizedBox(
                          width: 250,
                          child: TextField(
                            controller: _merrosEmail,
                            maxLines: 1,
                            maxLength: 100,
                            autocorrect: false,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                              hintText: 'email',
                              hintStyle: TextStyle(
                                color: HexColor(
                                        context.watch<brightessSwitch>().text)
                                    .withOpacity(0.8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor(context
                                        .watch<brightessSwitch>()
                                        .text)), // Colore del bordo quando l'input è abilitato
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SizedBox(
                          width: 250,
                          child: TextField(
                            controller: _merrosPassord,
                            maxLines: 1,
                            maxLength: 100,
                            autocorrect: false,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                              hintText: 'password',
                              hintStyle: TextStyle(
                                color: HexColor(
                                        context.watch<brightessSwitch>().text)
                                    .withOpacity(0.8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor(context
                                        .watch<brightessSwitch>()
                                        .text)), // Colore del bordo quando l'input è abilitato
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: _deeple,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !regexDeeple.hasMatch(value)) {
                                _scrollController.animateTo(
                                  1500,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                                return 'inserisci una key valida';
                              }
                              return null;
                            },
                            maxLines: 1,
                            maxLength: 39,
                            autocorrect: false,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                              hintText: 'key',
                              hintStyle: TextStyle(
                                color: HexColor(
                                        context.watch<brightessSwitch>().text)
                                    .withOpacity(0.8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor(context
                                        .watch<brightessSwitch>()
                                        .text)), // Colore del bordo quando l'input è abilitato
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 5),
                      child: Divider(
                        thickness: 4,
                        color: Colors.deepPurpleAccent.withOpacity(0.5),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text(
                          "GPT",
                          style: divider,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text(
                          'GPT setting',
                          style: subtitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Text('Temperature', style: title),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('handles randomness of responses',
                          style: subtitle),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SizedBox(
                          width: 150,
                          child: TextField(
                            controller: _temperature,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            maxLength: 3,
                            autocorrect: false,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                              hintText: '0.0 - 2.0',
                              hintStyle: TextStyle(
                                color: HexColor(
                                        context.watch<brightessSwitch>().text)
                                    .withOpacity(0.8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor(context
                                        .watch<brightessSwitch>()
                                        .text)), // Colore del bordo quando l'input è abilitato
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SizedBox(
                          width: 150,
                          child: TextField(
                            controller: _maxtoken,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            maxLength: 10,
                            autocorrect: false,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                              hintText: '30',
                              hintStyle: TextStyle(
                                color: HexColor(
                                        context.watch<brightessSwitch>().text)
                                    .withOpacity(0.8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor(context
                                        .watch<brightessSwitch>()
                                        .text)), // Colore del bordo quando l'input è abilitato
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 5),
                      child: Divider(
                        thickness: 4,
                        color: Colors.deepPurpleAccent.withOpacity(0.5),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 50,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _word.text = 'Virgilio';
                            _timeout.text = '3';
                            _energy.text = '3500';
                            _GPT.text =
                                'sk-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
                            _deeple.text =
                                'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
                            _meteo.text = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
                            _merrosPassord.text = 'password';
                            _merrosEmail.text = 'email';
                            _temperature.text = '0.9';
                            _maxtoken.text = '30';
                            volume = 100;
                            language = 'it';
                            sendNewSetting();
                            final snackbar = SnackBar(
                              width: 300,
                              backgroundColor: HexColor('12aa15'),
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              animation: CurvedAnimation(
                                parent: AnimationController(
                                    duration: const Duration(milliseconds: 500),
                                    // Durata dell'animazione
                                    vsync: this),
                                curve: Curves
                                    .easeInOutQuart, // Curva dell'animazione);
                              ),
                              duration: const Duration(seconds: 2),
                              content: Text(
                                'New setting sent',
                                style: GoogleFonts.ubuntu(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Imposta il valore del raggio
                              ),
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: 'OK',
                                onPressed: () {},
                              ),
                            );
                            _messengerKey.currentState?.showSnackBar(snackbar);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepPurple),
                          ),
                          child: const Text('Default setting'),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              sendNewSetting();
              final snackbar = SnackBar(
                width: 300,
                backgroundColor: HexColor('12aa15'),
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                animation: CurvedAnimation(
                  parent: AnimationController(
                      duration: const Duration(milliseconds: 500),
                      // Durata dell'animazione
                      vsync: this),
                  curve: Curves.easeInOutQuart, // Curva dell'animazione);
                ),
                duration: const Duration(seconds: 2),
                content: Text(
                  'New setting sent',
                  style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Imposta il valore del raggio
                ),
                action: SnackBarAction(
                  textColor: Colors.white,
                  label: 'OK',
                  onPressed: () {},
                ),
              );
              _messengerKey.currentState?.showSnackBar(snackbar);
            }
          },
          backgroundColor: Colors.deepPurple,
          elevation: 10,
          child: const Icon(Icons.save, color: Colors.white),
        ),
      ),
    );
  }
}
