import 'dart:math';

import 'package:cat_and_dog/features/home/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:gap/gap.dart';

enum Action { user, animal }

List<String> results = [
  'I am hungry',
  'I want to sleep',
  'I want go to play',
  'Leave me alone',
  'I am angry',
  'I love you',
  'I want to take a bath',
  'I am scaring',
  'Yes',
  'No',
  'I do not understand',
  'Please play with me',
  'Angry',
  'I\'m so tired',
  'I am cold',
  'I\'m hot',
  'Aren\'t I cute today?',
  'Welcome back',
  'Give me some water',
  'Let\'s go',
  'Let me in',
  'I\'m stressing'
];

class DogHomeWidget extends StatefulWidget {
  const DogHomeWidget({super.key});

  @override
  State<DogHomeWidget> createState() => _DogHomeWidgetState();
}

class _DogHomeWidgetState extends State<DogHomeWidget> with WidgetsBindingObserver {
  late SpeechToText _speechToText;
  bool _speechEnabled = false;
  String _lastWords = '';
  final _random = Random();

  late AudioPlayer player;
  @override
  void initState() {
    _speechToText = SpeechToText();
    _initSpeech();
    player = AudioPlayer();
    (WidgetsBinding.instance).addObserver(this);
    // context.read<AppColorBLoc>().add(AppColorFetch(color: const Color(0xFFFF949B)));
    super.initState();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening(Action action) async {
    if (action == Action.animal) {
      _lastWords = '';
      await _speechToText.listen(onResult: (result) => _onSpeechResult(result, action));
      setState(() {});
    }
    if (action == Action.user) {
      _lastWords = '';
      await _speechToText.listen(onResult: (result) => _onSpeechResult(result, action));
      setState(() {});
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result, Action action) {
    print(result);
    if (action == Action.animal &&
        (result.recognizedWords.contains("gau") || result.recognizedWords.contains("gâu") || result.recognizedWords.contains("Go"))) {
      // check render 1 lần
      // if (_lastWords != "") {
      //   return;
      // }
      setState(() {
        // _lastWords = result.recognizedWords;
        // TODO: cần check logic đoạn này vì nó đang gặp vấn đê đoạn reander ra text, ... cần làm giả animation
        _lastWords = results[_random.nextInt(results.length)];
      });
    } else if (action == Action.user) {
      setState(() {
        _lastWords = result.recognizedWords;
      });
    } else {
      if (_lastWords != "") {
        return;
      }
      setState(() {
        _lastWords = "Không dịch được tiếng động vật";
      });
    }
  }

  @override
  void dispose() {
    player.dispose();
    (WidgetsBinding.instance).removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onPause();
        break;
      case AppLifecycleState.paused:
        onPause();
        break;
      case AppLifecycleState.detached:
        onPause();
        break;
      case AppLifecycleState.hidden:
        onPause();
        break;
    }
  }

  void changeAudio(String? audio) async {
    if (audio == null) {
      //TODO show alert
    }
    player.stop();

    await player.setAsset(audio!);
    player.play();
  }

  void onResumed() {
    if (player.processingState != ProcessingState.completed) {
      player.play();
    }
  }

  void onPause() {
    if (player.playing && player.processingState != ProcessingState.completed) {
      player.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        IconButton(
            onPressed: () {
              changeAudio(dogs[_random.nextInt(results.length)].audio);
            },
            // onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Translate',
            iconSize: 100,
            icon: !_speechToText.isNotListening ? SvgPicture.asset("assets/svg/mic_active.svg") : SvgPicture.asset("assets/svg/mic.svg")),
        (_speechToText.isListening || _lastWords != '')
            ? Container(
                padding: const EdgeInsets.all(16),
                height: 100,
                // constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 100),
                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(25.0)),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
                  child: Text(
                    (_speechToText.isListening)
                        ? _lastWords
                        : _speechEnabled
                            ? _lastWords
                            : 'voice',
                    maxLines: 2,
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(16),
                height: 100,
                constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 100),
                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(25.0)),
              ),
        const Gap(69),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onLongPressStart: (details) {
                if (_speechToText.isNotListening) {
                  _startListening(Action.user);
                }
              },
              onLongPressEnd: (details) {
                if (_speechToText.isListening) {
                  _stopListening();
                }
              },
              child: Container(
                width: size.width / 2.7,
                height: size.width / 2.7,
                padding: const EdgeInsets.fromLTRB(29, 18, 28, 18),
                constraints: const BoxConstraints(minHeight: 155, minWidth: 155, maxHeight: 200, maxWidth: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), spreadRadius: 0, blurRadius: 10, offset: const Offset(0, 0))],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset("assets/home/translate/translate_screen_1.png", width: 60, height: 78),
                      const Text(
                        'Long press to record voice',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onLongPressStart: (details) {
                if (_speechToText.isNotListening) {
                  _startListening(Action.animal);
                }
              },
              onLongPressEnd: (details) {
                if (_speechToText.isListening) {
                  _stopListening();
                }
              },
              child: Container(
                width: size.width / 2.7,
                height: size.width / 2.7,
                padding: const EdgeInsets.fromLTRB(29, 18, 28, 18),
                constraints: const BoxConstraints(minHeight: 155, minWidth: 155, maxHeight: 200, maxWidth: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), spreadRadius: 0, blurRadius: 10, offset: const Offset(0, 0))],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset("assets/home/translate/translate_screen_3.png", width: 60, height: 78),
                      const Text(
                        'Long press to record voice',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
