import 'package:cat_and_dog/features/routers/routers.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class SplashIntro2 extends StatelessWidget {
  const SplashIntro2({super.key});

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
        Positioned(
          // left: size.width / 10,
          top: size.height / 1.8,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 13, 20, 13),
            decoration: BoxDecoration(color: const Color(0xFF5EBB98), borderRadius: BorderRadius.circular(25)),
            child: const Text(
              'What help would you like to receive?',
              style: TextStyle(color: Colors.white, fontSize: 15, decoration: TextDecoration.none),
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
            left: size.width / 9,
            top: size.height / 1.5,
            // bottom: 0,
            child: _buildItem('Pet teasing sounds', 'assets/intro/image_2_1.png', const Color(0xFFA4AFDC), true)),
        Positioned(
          right: size.width / 9,
          top: size.height / 1.3,
          // bottom: 0,
          child: ClipPath(
            clipper: CustomShapeClipperRight(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(50, 13, 50, 13),
              decoration: const BoxDecoration(color: Color(0xFF81CAE7)),
              child: const Center(
                child: Text(
                  'Pet translation',
                  style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: size.width / 9,
          top: size.height / 1.15,
          // bottom: 0,
          child: ClipPath(
            clipper: CustomShapeClipperLert(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(50, 13, 50, 13),
              decoration: const BoxDecoration(color: Color(0xFFE88570)),
              child: const Center(
                child: Text(
                  'I WANT BOTH',
                  style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
        ),

        // buton next
        Positioned(
          bottom: 10,
          right: 10,
          child: IconButton(
            padding: const EdgeInsets.all(20),
            onPressed: () => goPageHome(context),
            style: IconButton.styleFrom(backgroundColor: const Color(0xFF81CAE7)),
            icon: const Icon(Icons.skip_next),
          ),
        )
      ],
    );
  }

  Widget _buildItem(String text, String image, Color color, bool isLeft) {
    // isLeft ? Positioned.fill(right: 0, top: 0, child: Image.asset(image)) : Positioned(left: 0, right: 0, child: Image.asset(image)),
    return ClipPath(
      clipper: isLeft ? CustomShapeClipperLert() : CustomShapeClipperRight(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(50, 13, 50, 13),
        decoration: BoxDecoration(color: color),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }

  void goPageHome(context) {
    Navigator.pushNamedAndRemoveUntil(context, Routers.home, (Route<dynamic> route) => false);
  }
}
