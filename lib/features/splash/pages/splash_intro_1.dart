import 'package:cat_and_dog/features/home/pages/home_page.dart';
import 'package:cat_and_dog/features/splash/pages/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SplashIntro1 extends StatefulWidget {
  final VoidCallback onTap;

  const SplashIntro1({super.key, required this.onTap});
  @override
  State<SplashIntro1> createState() => _SplashIntro1State();
}

class _SplashIntro1State extends State<SplashIntro1> {
  void gotoCatHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void gotoDogHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(isCatPage: false)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // if user image background
        // Positioned.fill(child: child)
        //background
        //TODO: check khi màn hình quay ngang
        Positioned(right: size.width / 8, top: 0, child: Image.asset("assets/intro/ellipse_1.png")),
        Positioned(right: size.width / 1.5, top: size.height / 1.4, child: Image.asset("assets/intro/ellipse_4.png")),
        Positioned(right: 0, bottom: 0, child: Image.asset("assets/intro/ellipse_5.png")),
        // main
        Positioned(top: size.height / 6, child: Image.asset("assets/intro/dog.png", width: 360, height: 280)),
        // background
        Positioned(right: size.width / 1.5, top: size.height / 9, child: Image.asset("assets/intro/ellipse_2.png")),
        Positioned(right: size.width / 10, top: size.height / 2, child: Image.asset("assets/intro/ellipse_3.png")),

        //text main
        Positioned(
          left: size.width / 18,
          top: size.height / 1.8,
          child: Container(
            padding: const EdgeInsets.fromLTRB(58, 13, 58, 13),
            constraints: const BoxConstraints(maxWidth: 320, maxHeight: 48),
            decoration: BoxDecoration(color: const Color(0xFF5EBB98), borderRadius: BorderRadius.circular(25)),
            child: const Text(
              'Do you have a dog or a cat?',
              style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.none),
            ),
          ),
        ),
        Positioned(
          left: size.width / 9,
          top: size.height / 1.5,
          child: GestureDetector(
            onTap: widget.onTap,
            child: SizedBox(
              width: 220,
              height: 63,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CustomShapeClipperLert(),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 63, maxWidth: 180),
                      // padding: const EdgeInsets.fromLTRB(40, 31, 73, 15),
                      // decoration: const BoxDecoration(color: Color(0xFFA4AFDC)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned.fill(child: Image.asset("assets/intro/background_text_1.png", width: 180, height: 63, fit: BoxFit.cover)),
                          const Positioned(
                            top: 30,
                            left: 40,
                            child: Text('I have a cat', style: TextStyle(color: Colors.white, fontSize: 12, decoration: TextDecoration.none)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(alignment: Alignment.topRight, child: Image.asset('assets/intro/image_1_1.png', width: 100, height: 52)),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: size.height / 1.3,
          // bottom: 0,
          child: GestureDetector(
            onTap: widget.onTap,
            child: SizedBox(
              width: 220,
              height: 63,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CustomShapeClipperRight(),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 63, maxWidth: 180),
                      // padding: const EdgeInsets.fromLTRB(34, 31, 77, 15),
                      // decoration: const BoxDecoration(color: Color(0xFF81CAE7)),
                      child: Stack(
                        children: [
                          Positioned.fill(child: Image.asset("assets/intro/background_text_2.png", width: 180, height: 63, fit: BoxFit.cover)),
                          const Positioned(
                            top: 30,
                            right: 80,
                            child: Text('I have a dog', style: TextStyle(color: Colors.white, fontSize: 12, decoration: TextDecoration.none)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(top: 0, right: 50, child: Image.asset('assets/intro/image_1_2.png', width: 53, height: 50)),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: size.width / 9,
          top: size.height / 1.15,
          // bottom: 0,
          child: GestureDetector(
            onTap: widget.onTap,
            child: SizedBox(
              width: 220,
              height: 63,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CustomShapeClipperLert(),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 63, maxWidth: 188),
                      // padding: const EdgeInsets.fromLTRB(44, 31, 66, 10),
                      // decoration: const BoxDecoration(color: Color(0xFFE88570)),
                      child: Stack(
                        children: [
                          Positioned.fill(child: Image.asset("assets/intro/background_text_3.png", width: 180, height: 63, fit: BoxFit.cover)),
                          const Positioned(
                            top: 30,
                            left: 50,
                            child: Text('I HAVE BOTH', style: TextStyle(color: Colors.white, fontSize: 12, decoration: TextDecoration.none)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(alignment: Alignment.topRight, child: Image.asset('assets/intro/image_1_3.png', width: 78, height: 45)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
