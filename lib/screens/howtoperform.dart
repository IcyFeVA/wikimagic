import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class HowToPerform extends StatefulWidget {
  const HowToPerform({Key? key}) : super(key: key);

  @override
  State<HowToPerform> createState() => _HowToPerformState();
}

class _HowToPerformState extends State<HowToPerform> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, '/');
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
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
    const bodyStyle = TextStyle(fontSize: 16.0, color: Colors.white);

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
              title: "Fractional shares",
              body:
                  "Instead of having to buy an entire share, invest any amount you want.",
              image: _buildImage('images/logo.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Learn as you go",
              body:
                  "Download the Stockpile app and master the market with our mini-lesson.",
              image: _buildImage('images/logo.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Kids and teens",
              body:
                  "Kids and teens can track their stocks 24/7 and place trades that you approve.",
              image: _buildImage('images/logo.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Full Screen Page",
              body:
                  "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
              image: _buildFullscreenImage(),
              decoration: pageDecoration.copyWith(
                contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                fullScreen: true,
                bodyFlex: 2,
                imageFlex: 3,
              ),
            ),
            PageViewModel(
              title: "Another title page",
              body: "Another beautiful body text for this example onboarding",
              image: _buildImage('images/logo.png'),
              footer: ElevatedButton(
                onPressed: () {
                  introKey.currentState?.animateScroll(0);
                },
                child: const Text(
                  'FooButton',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Title of last page - reversed",
              bodyWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Click on ", style: bodyStyle),
                  Icon(Icons.edit),
                  Text(" to edit a post", style: bodyStyle),
                ],
              ),
              decoration: pageDecoration.copyWith(
                bodyFlex: 2,
                imageFlex: 4,
                bodyAlignment: Alignment.bottomCenter,
                imageAlignment: Alignment.topCenter,
              ),
              image: _buildImage('images/logo.png'),
              reverse: true,
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
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Color(0xFF372A43),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
