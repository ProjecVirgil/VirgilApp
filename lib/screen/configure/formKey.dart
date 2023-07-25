// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virgil_app/screen/utils/swtichBrightness.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import "package:path_provider/path_provider.dart";

class formKey extends StatefulWidget {
  const formKey({super.key});

  @override
  State<formKey> createState() => _formKeyState();
}

class _formKeyState extends State<formKey> {
  RegExp regexKey = RegExp(r'^[a-f0-9]{32}$');
  bool isValid = true;

  final TextEditingController _key = TextEditingController();

  //KEY FORM
  final _formKey = GlobalKey<FormState>();

  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://github.com/Retr0100/ProjectVirgil');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossibile aprire l\'URL: $url';
    }
  }


  Future<void> writeKeyFile({required String key}) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/key.txt';
    File file = File(filePath);
    await file.writeAsString(key);
  }

  Future<String> readKeyFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/key.txt';
    File file = File(filePath);
    var id = await file.readAsString();
    return id;
  }

  @override
  void initState() {
    super.initState();
    _initializeSettings();
  }


  // Funzione per inizializzare le impostazioni
  void _initializeSettings() async {
    var currentKey = await readKeyFile();
    setState(() {
      setState(() {
        _key.text = currentKey;
      });
    });
  }

  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    //double screenHeight = screenSize.height;
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Center(
                  child: AnimatedDefaultTextStyle(
                      style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color:
                              HexColor(context.watch<brightessSwitch>().text)),
                      duration: const Duration(milliseconds: 500),
                      child: const Text('Configure your Virgil key'))),
              Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.deepPurple,
                        // Cambia il colore dei bordi qui
                        width: 2.0, // Imposta la larghezza dei bordi
                      ),
                    ),
                    child: TextFormField(
                      maxLines: 1,
                      validator: (value) {
                        if (!regexKey.hasMatch(value!)) {
                          return 'Key not valid';
                        }
                        return null;
                      },
                      controller: _key,
                      cursorColor: Colors.deepPurple,
                      style: TextStyle(
                          color:
                              HexColor(context.watch<brightessSwitch>().text)),
                      decoration: InputDecoration(
                        hintText: 'Insert the key',
                        hintStyle: TextStyle(
                            color: HexColor(
                                context.watch<brightessSwitch>().text)),
                        border: InputBorder.none,
                        // Rimuove il bordo predefinito del TextField
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ),
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      writeKeyFile(key: _key.text);
                      setState(() {
                        _opacity = 1;
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepPurple),
                  ),
                  child: const Text('Save key'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: GestureDetector(
                      onTap: () {
                        _launchURL();
                      },
                      child: Text(
                        "If you don't have a key for Virgil follow the instruction on github",
                        style: GoogleFonts.ubuntu(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue),
                      )),
                ),
              ),
            ],
          ),
          Positioned(
            left: (screenWidth - 360) / 2,
            bottom: 50,
            child: AnimatedOpacity(
              onEnd: () {
                setState(() {
                  _opacity = 0;
                });
              },
              opacity: _opacity,
              duration: const Duration(seconds: 2),
              curve: Curves.fastLinearToSlowEaseIn,
              child: AnimatedContainer(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.green),
                duration: const Duration(seconds: 2),
                child: Center(
                    child: Text(
                  'Key saved successfully',
                  style: GoogleFonts.ubuntu(
                      fontSize: 15, fontWeight: FontWeight.w400),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
