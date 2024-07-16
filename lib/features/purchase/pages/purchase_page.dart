import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Row(
            children: [Expanded(child: Container(color: Colors.yellow)), Expanded(child: Container(color: const Color(0xFFF3F3F4)))],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/purchase/purchase_mic.png", width: 140, height: 66),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 160, width: 160, child: Image.asset("assets/purchase/purchase_cat_removebg.png", width: 160, height: 160)),
                      SizedBox(height: 160, width: 160, child: Image.asset("assets/purchase/purchase_dog_removebg.png", width: 160, height: 160)),
                    ],
                  ),
                  const Gap(20),
                  const CustomButton(text: 'What help would you like to receive?', color: Color(0xFF5EBB98)),
                  const Gap(18),
                  const CustomButton(text: 'Find out what your pet really wants!', color: Color(0xFFE88570)),
                  const Gap(18),
                  const CustomButton(text: 'Pet language translator', color: Color(0xFF81CAE7)),
                  const Gap(35),
                  const Text('Try 3 days for free, then \$199.99/year',
                      style: TextStyle(color: Color(0xFF868686), fontSize: 10, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xFF8479E1),
                    ),
                    onPressed: () {},
                    child: const Text('SUBSCRIBE NOW', style: TextStyle(color: Color(0xFFFFFFFF))),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(color: Color(0xFF868686), fontSize: 10, fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(text: 'This subscription gives you unlimited access to all '),
                          TextSpan(
                            text: 'features of our app. ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'When the trial ends, you will be '),
                          TextSpan(
                            text: 'automatically charged \$199.99/year ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'until you cancel.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;

  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(320, 48),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text('Understanding Your Pet'),
        //       content: SingleChildScrollView(
        //         child: Column(
        //           children: <Widget>[
        //             Image.asset('assets/home/dog/dog_alert.png'),
        //             Text('Understanding what your pet thinks is easy and grabs his attention'),
        //             Text('\$199.99/year after trial ends'),
        //             TextButton(
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //               child: Text('START 3 DAYS FREE TRIAL'),
        //             ),
        //           ],
        //         ),
        //       ),
        //       actions: <Widget>[
        //         TextButton(
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //           child: const Text('Cancel'),
        //         ),
        //       ],
        //     );
        //   },
        // );
      },
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
    );
  }
}
