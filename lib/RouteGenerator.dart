import 'package:flutter/material.dart';
import 'package:virgil_app/screen/configure/configure.dart';
import 'package:virgil_app/screen/home.dart';
import 'package:virgil_app/screen/settinAcc.dart';
import 'package:virgil_app/screen/settingVirgil/settingsVirgil.dart';
import 'package:virgil_app/screen/signin_signup.dart';
import 'package:virgil_app/screen/exploreVirgil.dart';



class RouteGenerator{
  static Route<dynamic>generateRoute(RouteSettings settings){
    //final  args = settings.arguments;
    switch(settings.name){
      case 'home':
        return MaterialPageRoute(builder: (context) => const home());
      case 'signin_signup':
        return MaterialPageRoute(builder: (context) => const signin_signup());
      case 'explore':
        return MaterialPageRoute(builder: (context) => const explore());
      case 'settings':
        return MaterialPageRoute(builder: (context) => const settingsVirgil());
      case 'configure':
        return MaterialPageRoute(builder: (context) => const configure());
      case 'settingAcc':
        return MaterialPageRoute(builder: (context) => const settingAcc());
      default:
        return MaterialPageRoute(builder: (context) => const Text('ciao'));
    }
  }
}