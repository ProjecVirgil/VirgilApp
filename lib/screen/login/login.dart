// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:virgil_app/screen/utils/frostedGlass.dart';
import 'package:virgil_app/screen/login/titleLogin.dart';
import 'package:virgil_app/screen/login/formLogin.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      // Aggiorna lo stato di focus
      focus = _focusNode.hasFocus;
      if(focus){
        _opacity = 0;
      }else{
        _opacity = 1;
      }
    });
  }

  bool focus = false;
  double _opacity = 1.0;

  void _handleScreenTap() {
    // Rimuovi il focus dagli elementi di input
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleScreenTap,
      child: Scaffold(
        body: Stack(children: [
          const titleLogin(),
          ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 200),
              children:  [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Rimuovi il focus dagli elementi di input
                      _focusNode.unfocus();
                    },
                    child:  frostedGlass(
                      Width: 350.0,
                      Height: 400.0,
                      child: FocusScope(
                        child: Focus(
                            focusNode: _focusNode,
                            child: const formLogin()
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
          Positioned(
            bottom: -40,
            child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOutCubicEmphasized, //DA VEDERE
                opacity: _opacity,
                child: Image.asset('images/shape.png',scale: 1.2,)            ),
          )
        ]),
      ),
    );
  }
}
