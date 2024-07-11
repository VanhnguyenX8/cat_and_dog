import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:gap/gap.dart';

class CatHomeWidget extends StatefulWidget {
  const CatHomeWidget({super.key});

  @override
  State<CatHomeWidget> createState() => _CatHomeWidgetState();
}

class _CatHomeWidgetState extends State<CatHomeWidget> {
  late SpeechToText _speechToText;
  bool _speechEnabled = false;
  String _lastWords = '';
  @override
  void initState() {
    _speechToText = SpeechToText();
    _initSpeech();
    // context.read<AppColorBLoc>().add(AppColorFetch(color: const Color(0xFFFF949B)));
    super.initState();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: [
          IconButton(
              onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
              tooltip: 'Translate',
              iconSize: 100,
              icon: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic)),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Text(
              _speechToText.isListening
                  ? _lastWords
                  : _speechEnabled
                      ? 'Voice -> $_lastWords'
                      : 'voice',
            ),
          ),
          const Gap(69),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onLongPressStart: (details) {
                  if (_speechToText.isNotListening) {
                    _startListening();
                  }
                },
                onLongPressEnd: (details) {
                  if (_speechToText.isListening) {
                    _stopListening();
                  }
                },
                child: Container(
                  width: size.width / 2.7,
                  padding: const EdgeInsets.fromLTRB(29, 18, 28, 28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), spreadRadius: 0, blurRadius: 10, offset: const Offset(0, 0))],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset("assets/home/translate/translate_screen_1.png"),
                        const Text('Long press to record voice', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onLongPressStart: (details) {
                  if (_speechToText.isNotListening) {
                    _startListening();
                  }
                },
                onLongPressEnd: (details) {
                  if (_speechToText.isListening) {
                    _stopListening();
                  }
                },
                child: Container(
                  width: size.width / 2.7,
                  padding: const EdgeInsets.fromLTRB(29, 18, 28, 28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), spreadRadius: 0, blurRadius: 10, offset: const Offset(0, 0))],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset("assets/home/translate/translate_screen_2.png"),
                        const Text('Long press to record voice', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
