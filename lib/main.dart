import 'package:WikiMagic/screens/about.dart';
import 'package:WikiMagic/screens/perform.dart';
import 'package:WikiMagic/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:WikiMagic/helpers/helpers.dart';
import 'package:WikiMagic/screens/howtoperform.dart';
import 'package:WikiMagic/screens/howitworks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';





Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Supabase.initialize(
    url: 'https://qpbuohnkvdddyhwnnost.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFwYnVvaG5rdmRkZHlod25ub3N0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzczMDg3NzYsImV4cCI6MTk5Mjg4NDc3Nn0.znCOPV0d_zHmT4it8tWB9kJQ7G9L0_KwA1nGc-Z9Mw4',
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  // final prefs = await SharedPreferences.getInstance();
  // final test = prefs.getBool('showHome') ?? false;

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserPageID()),
        ChangeNotifierProvider(create: (_) => MyUrl()),
        ChangeNotifierProvider(create: (_) => MySearchTerm()),
        ChangeNotifierProvider(create: (_) => MyFocusword()),
      ],
      child: MyApp()));

  FlutterNativeSplash.remove();
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
        '/howtoperform': (context) => HowToPerform(),
        '/about': (context) => About()
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


