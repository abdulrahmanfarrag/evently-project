import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../setup_screen/setup_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(

      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 100),
          child: Image.asset(
            'assets/images/horizontal_logo.png',
            height: 60,
          ),
        ),
      ),

      pages: [
        PageViewModel(
          titleWidget: buildTitle('Find Events That Inspire You'),
          bodyWidget: buildBody(
            'Dive into a world of events crafted to fit your unique interests. '
                'Whether you\'re into live music, art workshops, or networking, we have something for everyone.',
          ),
          image: buildImage('assets/images/onboarding1.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          titleWidget: buildTitle('Effortless Event Planning'),
          bodyWidget: buildBody(
            'Take the hassle out of organizing events with all-in-one planning tools. '
                'Set up invites, manage RSVPs, schedule reminders, and coordinate details easily.',
          ),
          image: buildImage('assets/images/onboarding2.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          titleWidget: buildTitle('Connect & Share Moments'),
          bodyWidget: buildBody(
            'Invite friends, stay connected, and share memories from every event. '
                'Celebrate moments together and keep them alive forever.',
          ),
          image: buildImage('assets/images/onboarding3.png'),
          decoration: getPageDecoration(),
        ),
      ],

      showSkipButton: true,
      skip: const Text(
        "Skip",
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
      next: const Icon(Icons.arrow_circle_right_outlined ,size: 40 ,color: Color(0xFF5669FF)),
      done: const Text(
        "Start",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF5669FF),
          fontSize: 20,
        ),
      ),

      dotsDecorator: getDotsDecorator(),
      onDone: () => Navigator.pushNamed(context, SetupScreen.routeName),
      onSkip: () => Navigator.pushNamed(context, SetupScreen.routeName),

    );
  }

  Widget buildTitle(String text) => Text(
    text,
    textAlign: TextAlign.left,
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xFF5669FF),
      height: 1.3,
    ),
  );

  Widget buildBody(String text) => Text(
    text,
    textAlign: TextAlign.left,
    style: const TextStyle(
      fontSize: 16,
      color: Color(0xFF1C1C1C),
      height: 1.6,
    ),
  );

  static Widget buildImage(String path) => Padding(
    padding: const EdgeInsets.only(top: 100),
    child: Center(
      child: Image.asset(
        path,
        height: 280,
        fit: BoxFit.contain,
      ),
    ),
  );


  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imagePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      pageColor: Colors.white,
      contentMargin: EdgeInsets.only(top: 140, left: 24, right: 24),
    );
  }

  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      size: Size(10, 10),
      color: Colors.grey,
      activeSize: Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      activeColor: Color(0xFF5669FF),
    );
  }
}