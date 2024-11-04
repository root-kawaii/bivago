import 'package:flutter/material.dart';
import 'package:bivago/pages/home_cnt.dart';
import 'package:bivago/pages/home.dart';
import 'package:bivago/themes/colors_theme.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final _introKey = GlobalKey<IntroductionScreenState>();
  int startInt = 0;
  String _status = 'Waiting...';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
        child: Stack(children: <Widget>[
      Container(
          child: IntroductionScreen(
        curve: Curves.easeIn,
        controlsMargin: EdgeInsets.zero,
        controlsPadding: const EdgeInsets.all(25.0),
        // 2. Pass that key to the `IntroductionScreen` `key` param
        key: _introKey,
        pages: [
          PageViewModel(
              title: '',
              bodyWidget: Column(
                children: [
                  Stack(children: <Widget>[
                    Center(
                        child: Text(
                      "Townly",
                      style: TextStyle(color: ThemeColor.orange, fontSize: 30),
                    )),
                    Container(
                      // height: 500,
                      child: SvgPicture.asset(
                        "assets/images/Aircraft.svg",
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ]),
                  Center(
                      child: Text(
                    "Benvenuto nella migliuto nella migliore app del mondo! Benvenuto nella miglioiore app del moore app del mondo! Benvenuto nella migliore app del mondo!",
                    style: TextStyle(color: ThemeColor.orange, fontSize: 15),
                  )),
                ],
              )),
          PageViewModel(
              title: '',
              bodyWidget: Column(
                children: [
                  Stack(children: <Widget>[
                    Center(
                        child: Text(
                      "Townly",
                      style: TextStyle(color: ThemeColor.orange, fontSize: 30),
                    )),
                    SizedBox(
                      height: 400,
                      child: SvgPicture.asset(
                        "assets/images/Departing.svg",
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ]),
                  Center(
                      child: Text(
                    "Benvenuto nella migliuto nella migliore app del mondo! Benvenuto nella miglioiore app del moore app del mondo! Benvenuto nella migliore app del mondo!",
                    style: TextStyle(color: ThemeColor.orange, fontSize: 15),
                  )),
                ],
              )),
          PageViewModel(
              title: '',
              bodyWidget: Column(
                children: [
                  Stack(children: <Widget>[
                    Center(
                        child: Text(
                      "Townly",
                      style: TextStyle(color: ThemeColor.orange, fontSize: 30),
                    )),
                    Container(
                      // height: 500,
                      child: SvgPicture.asset(
                        "assets/images/Traveling.svg",
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ]),
                  Center(
                      child: Text(
                    "Benvenuto nella migliuto nella migliore app del mondo! Benvenuto nella miglioiore app del moore app del mondo! Benvenuto nella migliore app del mondo!",
                    style: TextStyle(color: ThemeColor.orange, fontSize: 15),
                  )),
                ],
              )),
          PageViewModel(
              title: '',
              bodyWidget: Column(
                children: [
                  Stack(children: <Widget>[
                    Center(
                        child: Text(
                      "Townly",
                      style: TextStyle(color: ThemeColor.orange, fontSize: 30),
                    )),
                    Container(
                      // height: 500,
                      child: SvgPicture.asset(
                        "assets/images/Aircraft.svg",
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ]),
                  Center(
                      child: Text(
                    "Benvenuto nella migliuto nella migliore app del mondo! Benvenuto nella miglioiore app del moore app del mondo! Benvenuto nella migliore app del mondo!",
                    style: TextStyle(color: ThemeColor.orange, fontSize: 15),
                  )),
                ],
              ))
        ],
        showNextButton: false,
        showDoneButton: false,
      )),
      Positioned(
          bottom: 90,
          // right: screenWidth * 0.045,
          child: GestureDetector(
            onTap: () {
              if (startInt < 3) {
                startInt += 1;
                setState(() => _status = 'Going to the next page...');

                // 3. Use the `currentState` member to access functions defined in `IntroductionScreenState`
                Future.delayed(const Duration(milliseconds: 300),
                    () => _introKey.currentState?.next());
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomePage()),
                  // (Route<dynamic> route) => false,
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Margin to add space on the sides
              padding: const EdgeInsets.symmetric(
                  vertical: 16.0), // Padding for vertical spacing
              width: screenWidth * 0.9, // Full width of the screen
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 224, 122, 12), // Background color
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              child: const Center(
                child: Material(
                    color: Color.fromARGB(255, 224, 122, 12),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 18.0, // Text size
                        fontWeight: FontWeight.bold, // Text weight
                      ),
                    )),
              ),
            ),
          ))
    ]));
  }
}
