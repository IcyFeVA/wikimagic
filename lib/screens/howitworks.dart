import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class HowItWorks extends StatefulWidget {
  const HowItWorks({Key? key}) : super(key: key);

  @override
  State<HowItWorks> createState() => _HowItWorksState();
}

class _HowItWorksState extends State<HowItWorks> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, '/');
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 14.0, color: Colors.white);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: const Color(0xFF2A1E36),
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: const Color(0xFF2A1E36),
          globalHeader: Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: OutlinedButton(
                    child: Icon(Icons.arrow_back, color: Colors.teal),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: Color(0xFF2A1E36)),
                  ),
                ), //_buildImage('images/logo.png', 30),
              ),
            ),
          ),
          globalFooter: Container(),
          pages: [
            PageViewModel(
              title: "How it works",
              body:
                  "When you click 'CONNECT & PERFORM' on the home screen, this app connects to a database in the cloud and returns a unique URL. \n\n"
                      " If a spectator visits this particular URL with their phone, they will be presented with a fake wikipedia website. \n\n"
                      " At the same time, their phone will be connected to that same database in the cloud.",
              image: _buildImage('images/logo.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "",
              body:
                "If they search something, that search-term will be pushed to the database. The same goes for words they select. \n\n"
                "At the same time, this app receives these words and displays them on the peek-screen of your choosing.",
              image: _buildImage('images/logo.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "",
              body:
                "You can try this out yourself and once you get the hang of it, head on over the the 'PERFORMANCE PATTERN' section to learn how to perform this miracle.",
              image: _buildImage('images/logo.png'),
              footer: ElevatedButton(
                child: const Text('TAKE ME THERE'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/howtoperform');
                },
                style: ButtonStyle(
                  minimumSize:
                  MaterialStateProperty.all(Size(300, 50)),
                  backgroundColor:
                  MaterialStateProperty.all(Color(0xFF372A43)),
                ),
              ),
              decoration: pageDecoration,
            ),

          ],
          onDone: () => _onIntroEnd(context),
          //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: false,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: true,
          //rtl: true, // Display as right-to-left
          back: const Text(
            'BACK',
            style: TextStyle(color: Colors.teal),
          ), //const Icon(Icons.arrow_back, color: Colors.teal),
          skip: const Text('SKIP',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.teal)),
          next: const Text(
            'NEXT',
            style: TextStyle(color: Colors.teal),
          ),
          done: const Text('HOME',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.teal)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFFFFFFF),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Color(0x002A1E36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
