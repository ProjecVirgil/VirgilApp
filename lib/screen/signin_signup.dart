import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:virgil_app/screen/login/login.dart';
import 'package:virgil_app/screen/signup/signup.dart';

import 'utils/swtichBrightness.dart';

// ignore: camel_case_types
class signin_signup extends StatefulWidget {
  const signin_signup({super.key});

  @override
  State<signin_signup> createState() => _signin_signupState();
}

// ignore: camel_case_types
class _signin_signupState extends State<signin_signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: const TabBarView(children: [login(), signup()]),
          bottomNavigationBar: SizedBox(
            width: 200,
            height: 50,
            child: Container(
              color: HexColor(context.watch<brightessSwitch>().background),
              child:  TabBar(
                  //MODIFY STYLE
                  indicatorWeight: 4,
                  indicatorColor: HexColor("#A58EF5"),
                  tabs: [
                    Tab(
                      icon: Icon(Icons.login,color: HexColor(context.watch<brightessSwitch>().text) ,),
                    ),
                    Tab(
                      icon: Icon(Icons.add_circle,color: HexColor(context.watch<brightessSwitch>().text) ,),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
