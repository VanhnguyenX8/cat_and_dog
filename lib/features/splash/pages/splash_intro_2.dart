import 'package:cat_and_dog/features/home/pages/home_page.dart';
import 'package:cat_and_dog/features/routers/routers.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class SplashIntro2 extends StatefulWidget {
  const SplashIntro2({super.key});

  @override
  State<SplashIntro2> createState() => _SplashIntro2State();
}

class _SplashIntro2State extends State<SplashIntro2> {
  void gotoCatHome() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (Route<dynamic> route) => false);
  }

  void gotoDogHome() {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(isCatPage: false)));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage(isCatPage: false)), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // if user image background
        // Positioned.fill(child: child)
        // background
        // TODO: check khi màn hình quay ngang
        Positioned(right: size.width / 8, top: 0, child: Image.asset("assets/intro/ellipse_1.png")),
        Positioned(right: size.width / 1.5, top: size.height / 1.4, child: Image.asset("assets/intro/ellipse_4.png")),
        Positioned(right: 0, bottom: 0, child: Image.asset("assets/intro/ellipse_5.png")),
        Positioned(right: size.width / 1.5, top: size.height / 9, child: Image.asset("assets/intro/ellipse_2.png")),
        Positioned(right: size.width / 10, top: size.height / 2, child: Image.asset("assets/intro/ellipse_3.png")),
        // main
        Positioned(top: size.height / 12, child: Image.asset("assets/intro/cat.png", width: 360, height: 280)),

        //text main
        Align(
          alignment: Alignment.center,
          heightFactor: 40,
          child: Container(
            margin: const EdgeInsets.only(top: 130),
            padding: const EdgeInsets.fromLTRB(23, 13, 23, 13),
            decoration: BoxDecoration(color: const Color(0xFF5EBB98), borderRadius: BorderRadius.circular(25)),
            child: const Text(
              'What help would you like to receive?',
              style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.none),
            ),
          ),
        ),
        // Positioned(
        //   left: size.width / 9,
        //   top: size.height / 1.5,
        //   // bottom: 0,
        //   child: ClipPath(
        //     clipper: CustomShapeClipperLert(),
        //     child: Container(
        //       padding: const EdgeInsets.fromLTRB(50, 13, 50, 13),
        //       decoration: const BoxDecoration(color: Color(0xFFA4AFDC)),
        //       child: const Center(
        //         child: Text(
        //           'Pet teasing sounds',
        //           style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.none),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Positioned(
            left: size.width / 7,
            top: size.height / 1.6,
            child: GestureDetector(
                onTap: gotoCatHome,
                child: _buildItem('Pet teasing sounds', 'assets/intro/image_2_1.png', const Color(0xFFA4AFDC), true, 71, 57,
                    'assets/intro/background_text_1.png'))),
        Positioned(
          right: size.width / 7,
          top: size.height / 1.36,
          child: GestureDetector(
              onTap: gotoDogHome,
              child: _buildItem(
                  'Pet translation', 'assets/intro/image_2_2.png', const Color(0xFF81CAE7), false, 53, 57, 'assets/intro/background_text_2.png')),
        ),
        Positioned(
          left: size.width / 7,
          top: size.height / 1.17,
          child: GestureDetector(
              onTap: gotoCatHome,
              child: _buildItem(
                  'I WANT BOTH', 'assets/intro/image_2_3.png', const Color(0xFFE88570), true, 43.766, 60.712, 'assets/intro/background_text_3.png')),
        ),

        // buton next
        // Positioned(
        //   bottom: 10,
        //   right: 10,
        //   child: IconButton(
        //     padding: const EdgeInsets.all(20),
        //     onPressed: () => goPageHome(context),
        //     style: IconButton.styleFrom(backgroundColor: const Color(0xFF81CAE7)),
        //     icon: const Icon(Icons.skip_next),
        //   ),
        // )
      ],
    );
  }

  Widget _buildItem(String text, String image, Color color, bool isLeft, double width, double height, String imageBackGround) {
    // isLeft ? Positioned.fill(right: 0, top: 0, child: Image.asset(image)) : Positioned(left: 0, right: 0, child: Image.asset(image)),
    return SizedBox(
      width: isLeft ? 215 : 190,
      height: 80,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: ClipPath(
              clipper: isLeft ? CustomShapeClipperLert() : CustomShapeClipperRight(),
              child: Container(
                // padding: const EdgeInsets.fromLTRB(25, 25, 50, 13),
                constraints: const BoxConstraints(maxHeight: 63, maxWidth: 188),
                // decoration: BoxDecoration(color: color),
                child: Stack(
                  children: [
                    Positioned.fill(child: Image.asset(imageBackGround, width: 193, height: 63, fit: BoxFit.cover)),
                    Positioned(
                      top: 30,
                      left: 30,
                      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12, decoration: TextDecoration.none)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(right: isLeft ? 10 : 20, top: 10, child: Image.asset(image, width: width, height: height))
        ],
      ),
    );
  }

  void goPageHome(context) {
    Navigator.pushNamedAndRemoveUntil(context, Routers.home, (Route<dynamic> route) => false);
  }
}
