
import 'package:DRHealth/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

    final introKey = GlobalKey<IntroductionScreenState>();

    void _onIntroEnd(context) {
      Navigator.pushNamed(context, '/products_screen');
    }

    Widget _buildImage(String assetName) {

      return ClipRRect(
          borderRadius: BorderRadius.circular(120.0),
          child: Container(
          height: 30,
          width: 30,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),
            color: Colors.white
          ),
          child: Image(
            image: AssetImage(assetName),
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
      );
      
    }

    @override
    void initState() {
      super.initState();
        SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      );

    }
 
  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 18.0, color: Color(0xff9F5DE2));
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700, color: Color(0xff7B4397)),
      bodyTextStyle: bodyStyle,
      pageColor: Color(0xfff4f4f4),
      imagePadding: EdgeInsets.all(60),
    );

    return Scaffold(
        body: Center(
          child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: IntroductionScreen(
            key: introKey,
            pages: [
              PageViewModel(
                title: "DROHealth",
                body:
                    "...all round quality healthcare",
                image: _buildImage(BACKGROUND_IMAGE),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            done: const Text('Continue', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff0CB8B6))),
            dotsDecorator: const DotsDecorator(
              activeSize: Size(0.0, 0.0),
            ),
          ),
      ),
        ),
    );
    
  }
}