import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../utils/swtichBrightness.dart';



class formStringAPI extends StatelessWidget {
  const formStringAPI({
    Key? key,
    required this.controller,
    required this.regex,
    required this.maxleng,
    required this.scrollController,
  }) : super(key: key);

  final TextEditingController controller;
  final RegExp regex;
  final int maxleng;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: SizedBox(
          width: 250,
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (!regex.hasMatch(value!)) {
                scrollController.animateTo(
                  1200,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
                return 'Inserisci una key valida';
              }
              return null;
            },
            maxLines: 1,
            maxLength: maxleng,
            autocorrect: false,
            cursorColor: Colors.deepPurple,
            decoration: InputDecoration(
              hintText: 'Key',
              hintStyle: TextStyle(
                color: HexColor(
                    context.watch<brightessSwitch>().text)
                    .withOpacity(0.8),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor(
                      context.watch<brightessSwitch>().text),
                ), // Colore del bordo quando l'input è abilitato
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
