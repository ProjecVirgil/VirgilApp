import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virgil_app/RouteGenerator.dart';
import 'package:virgil_app/screen/configure/configure.dart';
import 'package:virgil_app/screen/signin_signup.dart';
import 'package:virgil_app/screen/home.dart';
import 'package:virgil_app/screen/utils/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:virgil_app/screen/utils/swtichBrightness.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => brightessSwitch() )],
        child:const MyApp(),) );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Virgil app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            brightness: Brightness.dark,
            primaryColorDark: Colors.deepPurpleAccent[600],
            accentColor: Colors.deepPurpleAccent[600],
            errorColor: const Color.fromARGB(255, 244, 10, 0)),
      ),
      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Effettua la transizione verso la pagina Home
            WidgetsBinding.instance.addPostFrameCallback((_) {
              navigatorKey.currentState?.push(
                MaterialPageRoute(builder: (context) => const home()),
              );
            });
          } else {
            // Effettua la transizione verso la pagina SigninSignup
            WidgetsBinding.instance.addPostFrameCallback((_) {
              navigatorKey.currentState?.push(
                MaterialPageRoute(builder: (context) => const signin_signup()),
              );
            });
          }
          return Container();
        },
      ),
      onGenerateRoute: RouteGenerator.generateRoute, //DINAMICO
    );
  }
}
