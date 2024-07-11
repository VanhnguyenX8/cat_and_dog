import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class MoveAppPage extends StatelessWidget {
  const MoveAppPage({super.key, this.onPopInvoked, required this.storeLink});
  final void Function(BuildContext context)? onPopInvoked;
  final String storeLink;

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final padding = mediaData.padding;
    final double paddingLeft = max(12, padding.left);
    final double paddingRight = max(12, padding.right);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop || onPopInvoked == null) return;
        onPopInvoked?.call(context);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Ứng dụng gặp lỗi')),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: paddingLeft, right: paddingRight, top: 10, bottom: max(12, padding.bottom)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ứng dụng gặp lỗi trong quá trình khởi động.'),
                const Gap(10),
                Text.rich(TextSpan(
                  children: [
                    const TextSpan(text: 'Vui lòng '),
                    TextSpan(
                      text: 'tải lại',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = getApp,
                    ),
                    const TextSpan(text: ' ứng dụng.'),
                  ],
                )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: TextButton(
          onPressed: getApp,
          child: const Text('Tải lại', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  void getApp() async {
    final url = storeLink;
    if (url.isEmpty) return;
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }
}
