// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:core';
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
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../RouteGenerator.dart';
import '../utils/fixedBehavior.dart';
import 'formString.dart';

class settingsVirgil extends StatefulWidget {
  const settingsVirgil({super.key});

  @override
  State<settingsVirgil> createState() => _settingsVirgilState();
}

class _settingsVirgilState extends State<settingsVirgil>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  //OPACITY
  double _opacity = 0;
  double _opacityNullError = 0.0;
  //KEY FORM
  final formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  //CONTROLLER TEXT
  final TextEditingController _word = TextEditingController();
  final TextEditingController _timeout = TextEditingController();
  final TextEditingController _energy = TextEditingController();
  final TextEditingController _GPT = TextEditingController();
  final TextEditingController _merrosEmail = TextEditingController();
  final TextEditingController _merrosPassord = TextEditingController();
  final TextEditingController _temperature = TextEditingController();
  final TextEditingController _maxtoken = TextEditingController();
  final TextEditingController _Eleven = TextEditingController();
  //VALORI SETING
  String language = 'en';
  bool _isDynamic = false;
  double volume = 100;
  List<geocoding.Placemark> _city = [];




  //REGEX
  RegExp regexForazAZ09 =  RegExp(r'^[a-zA-Z0-9-]*$');
  RegExp regex09afAF32 = RegExp(r'^[0-9A-Fa-f]{32}|^$');
  RegExp regexaz0939 = RegExp(r'^[a-z0-9:-]{39}|^$');

  Future<String?> readKeyFile() async {
    try{
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/key.txt';
      File file = File(filePath);
      var id = await file.readAsString();
      return id;
    }
    catch(error){
      return null;
    }

  }

  sendNewSetting() async {
    var id = await readKeyFile();
    if(id == null ){
      return false;
    }
    else {
      String url =
          'https://fastapi-production-cd01.up.railway.app/api/setting/modify/$id/';
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
        "operation_timeout": _timeout.text.toString(),
        "dynamic_energy_threshold": _isDynamic.toString(),
        "energy_threshold": _energy.text.toString(),
        "elevenlabs": _Eleven.text,
        "openAI": _GPT.text,
        "merrosEmail": _merrosEmail.text,
        "merrosPassword": _merrosPassord.text,
        "temperature": _temperature.text.toString(),
        "max_tokens": _maxtoken.text.toString(),
      };


      await http.post(
        Uri.parse(url),
        body: jsonEncode(settingUpdate),
        headers: headers,
      );

      return true;
    }
  }

    @override
    void initState() {
      super.initState();
      _initializeSettings();
    }



  Future<dynamic> getSetting() async {
    var id = await readKeyFile();
      String url = 'https://fastapi-production-cd01.up.railway.app/api/setting/$id/';
      var headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      dynamic currentSetting = json.decode(response.body);
      return currentSetting['setting'];
    }


  // Funzione per inizializzare le impostazioni
  void _initializeSettings() async {
    var currentSetting = await getSetting();
    setState(() {
      _word.text = currentSetting['wordActivation'];
      _timeout.text = currentSetting['operation_timeout'];
      language = currentSetting['language'];
      _GPT.text = currentSetting['openAI'];
      _merrosPassord.text = currentSetting['merrosPassword'];
      _merrosEmail.text = currentSetting['merrosEmail'];
      _isDynamic = currentSetting['dynamic_energy_threshold'].toLowerCase() == "true";
      _maxtoken.text = currentSetting['max_tokens'];
      _temperature.text = currentSetting['temperature'];
      _Eleven.text = currentSetting['elevenlabs'];
      _energy.text = currentSetting['energy_threshold'];
      volume = double.parse(currentSetting['volume']);
    });
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
    double screenHeight = screenSize.height;

    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute, //DINAMICO
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        key: _globalKey,
        drawer: const sideBar(),
        body: AnimatedContainer(
          color: HexColor(context.watch<brightessSwitch>().background),
          duration: const Duration(seconds: 1),
          child: Stack(
            children: [
              ScrollConfiguration(
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
                        child: const Text('Modify setting of Virgil')),
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
                  SliverPadding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    sliver: Form(
                      key: formKey,
                      child: SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 18.0),
                            child: AnimatedDefaultTextStyle(
                              style: divider,
                              duration: const Duration(milliseconds: 500),
                              child: const Text('General',
                                  textAlign: TextAlign.center,),
                            ),
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
                              focusColor: HexColor("#290043"),
                              dropdownColor: HexColor("#290043"),
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
                                style : TextStyle(color: HexColor(context.watch<brightessSwitch>().text)),
                                controller: _word,
                                validator: (value) {
                                  if (!regexForazAZ09.hasMatch(value!)) {
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
                                cursorColor: HexColor("#290043"),
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
                                  focusedBorder:  UnderlineInputBorder(
                                    borderSide: BorderSide(color:HexColor("#290043")),
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
                            inactiveColor: HexColor("#290043"),
                            activeColor: HexColor("#290043"),
                            thumbColor: HexColor("#682B8F"),
                            divisions: 9,
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
                                        HexColor("#290043"))),
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
                              color: HexColor("#4b008e").withOpacity(0.5),
                            ),
                          ),
                          Center(
                            child: AnimatedDefaultTextStyle(
                              style: divider,
                              duration: const Duration(milliseconds:500),
                              child: const Text(
                                "Listener",

                              ),
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
                                  style : TextStyle(color: HexColor(context.watch<brightessSwitch>().text)),

                                  controller: _timeout,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  maxLength: 10,
                                  autocorrect: false,
                                  cursorColor: HexColor("#4b008e"),
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
                                    focusedBorder:  UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: HexColor("#4b008e")),
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
                                  style : TextStyle(color: HexColor(context.watch<brightessSwitch>().text)),

                                  controller: _energy,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  maxLength: 10,
                                  autocorrect: false,
                                  cursorColor: HexColor("#4b008e"),
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
                                    focusedBorder:  UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: HexColor("#4b008e")),
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
                                value: _isDynamic,
                                onChanged: (bool value) {
                                  setState(() {
                                    _isDynamic = value;
                                  });
                                },
                                activeColor: HexColor("#4b008e"),
                              ),
                            ),
                            //DA AGGIUNGERE CHEKBOX TRUE FALSE
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 5),
                            child: Divider(
                              thickness: 4,
                              color: HexColor("#4b008e").withOpacity(0.5),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: AnimatedDefaultTextStyle(
                                style: divider,
                                duration: const Duration(milliseconds:500),
                                child: const Text(
                                  "API",
                                ),
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
                          formStringAPI(controller: _GPT, regex: regexForazAZ09, maxleng: 51, scrollController: _scrollController,),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text('ElevenLabs', style: title),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('API for TTS not obligatory', style: subtitle),
                          ),
                          formStringAPI(controller: _Eleven, regex: regex09afAF32, maxleng: 32, scrollController: _scrollController,),
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
                                  style : TextStyle(color: HexColor(context.watch<brightessSwitch>().text)),

                                  controller: _merrosEmail,
                                  maxLines: 1,
                                  maxLength: 100,
                                  autocorrect: false,
                                  cursorColor: HexColor("#290043"),
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
                                    focusedBorder:  UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: HexColor("#290043")),
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
                                  style : TextStyle(color: HexColor(context.watch<brightessSwitch>().text)),

                                  controller: _merrosPassord,
                                  maxLines: 1,
                                  maxLength: 100,
                                  autocorrect: false,
                                  cursorColor: HexColor("#290043"),
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
                                    focusedBorder:  UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: HexColor("#290043")),
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
                              color: HexColor("#4b008e").withOpacity(0.5),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: AnimatedDefaultTextStyle(
                                style: divider,
                                duration:const Duration(milliseconds:500),
                                child: const Text(
                                  "GPT",
                                ),
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
                                  style : TextStyle(color: HexColor(context.watch<brightessSwitch>().text)),

                                  controller: _temperature,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  maxLength: 3,
                                  autocorrect: false,
                                  cursorColor: HexColor("#290043"),
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
                                    focusedBorder:  UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: HexColor("#290043")),
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
                                  style : TextStyle(color: HexColor(context.watch<brightessSwitch>().text)),

                                  controller: _maxtoken,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  maxLength: 10,
                                  autocorrect: false,
                                  cursorColor: HexColor("#290043"),
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
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(
                                              color: HexColor("#290043")
                                          ),
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
                              color: HexColor("#4b008e").withOpacity(0.5),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 50,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _opacity = 1;
                                  });
                                  _word.text = 'Virgilio';
                                  _timeout.text = '3';
                                  _energy.text = '3500';
                                  _Eleven.text = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
                                  _GPT.text =
                                      'sk-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
                                  _merrosPassord.text = 'password';
                                  _merrosEmail.text = 'email';
                                  _temperature.text = '0.9';
                                  _maxtoken.text = '30';
                                  volume = 100;
                                  language = 'it';
                                  sendNewSetting();

                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      HexColor("#290043")),
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
              ),
              Positioned(
                left: (screenWidth - (screenWidth-100)) / 2,
                bottom: screenHeight / 2,
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(seconds: 2),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: AnimatedContainer(
                    width: screenWidth - 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.green),
                    duration: const Duration(seconds: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [ Text(
                        'New settings sent ',
                        style: GoogleFonts.ubuntu(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ElevatedButton(style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                        onPressed: () {
                      setState(() {
                        _opacity = 0;
                      });
                    }, child: const Text('OK'))
                    ]
                    ),
                  ),
                ),
              ),
              Positioned(
                left: (screenWidth - (screenWidth-100)) / 2,
                bottom: (screenHeight - 110) / 2,
                child: AnimatedOpacity(
                  opacity: _opacityNullError,
                  duration: const Duration(seconds: 2),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: AnimatedContainer(
                    width: screenWidth - 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.red),
                    duration: const Duration(seconds: 2),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [ Text(
                          'The key is empty',
                          style: GoogleFonts.ubuntu(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                          ElevatedButton(style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                              onPressed: () {
                                setState(() {
                                  _opacityNullError = 0;
                                });
                              }, child: const Text('OK'))
                        ]
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              bool res = await sendNewSetting(); // Attendere il completamento della Future
              if (res) {
                setState(() {
                  _opacity = 1;
                });
              } else {
                setState(() {
                  _opacityNullError = 1;
                });
              }
            }
          },
          backgroundColor: HexColor("#290043"),
          elevation: 10,
          child: const Icon(Icons.save, color: Colors.white),
        ),
      ),
    );
  }
}
