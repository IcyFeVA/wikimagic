import 'dart:async';

import 'package:WikiMagic/screens/perform.dart';
import 'package:WikiMagic/screens/home.dart';
import 'package:WikiMagic/services/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/user.dart';
import 'services/auth.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  final prefs = await SharedPreferences.getInstance();
  final test = prefs.getBool('showHome') ?? false;

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => MyUser())
      ],
      child: MyApp()));
}


class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().user,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          if(signedIn) {
            return Perform();
          } else {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Home()),
            // );
            return Home();
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return const Text('Something weird is going on');
      },
    );
  }
}



class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final User user = Provider.of<User>(context);
    //final AuthService user = Provider.of<AuthService>(context);
    //final AuthService auth = Provider.of<AuthService>(context);

    // return StreamBuilder(
    //   stream: auth.user,
    //   builder: (context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       final bool signedIn = snapshot.hasData;
    //       return signedIn ? Perform() : Home();
    //     }
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const CircularProgressIndicator();
    //     }
    //     return const Text('Something weird is going on');
    //   },
    // );

    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => const Wrapper(),
        '/home': (context) => Home(),
        '/perform': (context) => const Perform()
      },
    );

  }
}


