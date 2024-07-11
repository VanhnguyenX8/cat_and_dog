import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
        // child: BaiTap365ProgressIndicator(),
      ),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key, this.isDisplayText = true});
  final bool isDisplayText;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: CupertinoActivityIndicator(),
        // child: BaiTap365ProgressIndicator(isDisplayText: isDisplayText),
      ),
    );
  }
}
