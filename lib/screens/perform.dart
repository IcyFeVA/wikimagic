import 'package:WikiMagic/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:animations/animations.dart';
import 'perform_display.dart';


final supabase = Supabase.instance.client;


class Perform extends StatefulWidget {
  const Perform({Key? key}) : super(key: key);

  @override
  State<Perform> createState() => _PerformState();
}

class _PerformState extends State<Perform> {

  final Future<dynamic> _future = supabase.from('userdata').select('url');

  bool _isPerforming = false;
  bool _readyToPerform = false;

  void _togglePerformStatus() {
    setState(() {
      _isPerforming = !_isPerforming;
    });
  }


  Future<bool> _onWillPop() async {
    Navigator.pushNamed(context, '/');
    return true;
  }





  Widget urlDisplay() {

    void insertDefaults(url) async {
      await supabase
          .from('userdata')
          .insert({'url': url, 'searchterm': '-', 'focusword': '-'});
    }

    String generateNewURL(db) {

      bool duplicateFound = false;
      String genUrl = generateRandomString(3);

      for(var i=0; i<db.length; i++) {
        if(db[i]['url'] == genUrl) {
          print('DUPLICATE URL FOUND ' + genUrl);
          duplicateFound = true;
        }
      }
      if(duplicateFound) {
        print('GENERATING NEW URL AFTER DUPLICATE WAS FOUND');
        return generateNewURL(db);
      } else {
        print('NEW URL ' + genUrl);

        insertDefaults(genUrl);
        _readyToPerform = true;

        return genUrl;
      }
    }




    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return Container(
            margin: EdgeInsets.only(bottom: 116),
            child: CircularProgressIndicator(),
          );
        } else {
          final db = snapshot.data!;

          String myUrl = generateNewURL(db);

          if (!_readyToPerform) {
            return Container(
              margin: EdgeInsets.only(bottom: 116),
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(bottom: 128),
              child: Text(
                'wima.app/' + myUrl,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            );
          }

        }
      },
    );
  }

  Widget PerformHome() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF07080D),
              Color(0xFF131523),
              Color(0xFF07080D),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 64),
            padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 0),
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Your spectators url',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),

              urlDisplay(),

              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: const [
                      Text(
                        'Peek spectators thoughts',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16,
                            decoration: TextDecoration.none),
                      ),
                      Text(
                        '(Double-Tap to exit screen)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFFBABABA),
                            fontSize: 13,
                            decoration: TextDecoration.none),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _togglePerformStatus();
                  },
                  child: const Text('ALWAYS ON DISPLAY'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF171B33)),
                    minimumSize: MaterialStateProperty.all(Size(300, 50)),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('BLACK SCREEN'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF171B33)),
                      minimumSize: MaterialStateProperty.all(Size(300, 50)),
                    ),
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('BROWSER'),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF171B33)),
                    minimumSize: MaterialStateProperty.all(Size(300, 50)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('PEEKSMITH'),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF171B33)),
                    minimumSize: MaterialStateProperty.all(Size(300, 50)),
                  ),
                ),
              ),
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 72),
              child: ElevatedButton(
                onPressed: () async {
                  _onWillPop();
                },
                child: const Text('END SESSION'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(300, 50)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF5E41D4)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Container(
            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 300),
              reverse: !_isPerforming,
              transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  ) {
                return SharedAxisTransition(
                  child: child,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                );
              },
              child: _isPerforming
                  ? PerformDisplay(toggle: _togglePerformStatus)
                  : PerformHome(),
            ),
          ),
        ),
      ),
    );

  }
}
