import 'package:flutter/material.dart';
import 'package:virgil_app/explore/pageCard.dart';
import 'package:virgil_app/screen/configure/configure.dart';
import 'package:virgil_app/screen/home.dart';
import 'package:virgil_app/screen/settinAcc.dart';
import 'package:virgil_app/screen/settingVirgil/settingsVirgil.dart';
import 'package:virgil_app/screen/signin_signup.dart';
import 'package:virgil_app/explore/exploreVirgil.dart';



class RouteGenerator{
  static Route<dynamic>generateRoute(RouteSettings settings){
    final args = settings.arguments; // Passa gli argomenti dalla chiamata di pushNamed
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
      case 'pageCardExplore':
        if (args is PageCard) {
          return MaterialPageRoute(builder: (context) =>
           PageCard(title: args.title,
              text: args.text,
              pathImage: args.pathImage,
              icon: args.icon));
        }
        else {
          return MaterialPageRoute(builder: (context) => const Text('ciao'));
        }
      default:
        return MaterialPageRoute(builder: (context) => const Text('ciao'));
    }
  }
}