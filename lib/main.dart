import 'dart:async';

import 'package:WikiMagic/screens/perform.dart';
import 'package:WikiMagic/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:WikiMagic/helpers/helpers.dart';
import 'package:WikiMagic/screens/howtoperform.dart';
import 'package:WikiMagic/screens/howitworks.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  // final prefs = await SharedPreferences.getInstance();
  // final test = prefs.getBool('showHome') ?? false;

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserPageID()),
        ChangeNotifierProvider(create: (_) => MyUser()),
        ChangeNotifierProvider(create: (_) => MySearchTerm()),
        ChangeNotifierProvider(create: (_) => MySelection()),
      ],
      child: MyApp()));
}


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/perform': (context) => Perform(),
        '/howitworks': (context) => HowItWorks(),
        '/howtoperform': (context) => HowToPerform()
      },
      home: Home(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF07080D),
        canvasColor: const Color(0xFF07080D),
        primaryColor: Colors.deepPurple,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(secondary: Colors.white),
      ),
    );

  }
}


