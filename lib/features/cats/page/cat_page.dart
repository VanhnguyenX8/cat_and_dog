import 'dart:async';

import 'package:cat_and_dog/features/bloc/app_color_bloc.dart';
import 'package:cat_and_dog/features/cats/bloc/cat_bloc.dart';
import 'package:cat_and_dog/features/home/data/data.dart';
import 'package:cat_and_dog/features/home/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';

class CatPage extends StatefulWidget {
  const CatPage({super.key});

  @override
  State<CatPage> createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> with WidgetsBindingObserver {
  late AudioPlayer player;
  late StreamSubscription<PlayerState> playerStateSub;
  List<Animal> items1 = [];
  List<Animal> items2 = [];
  List<Animal> items3 = [];
  @override
  void initState() {
    player = AudioPlayer();
    //change background color
    context.read<AppColorBLoc>().add(AppColorFetch(color: const Color(0xFFFCFAFA)));
    //init List
    //call add event
    (WidgetsBinding.instance).addObserver(this);

    // hotfix: reload in this page
    // context.read<CatBloc>().add(CatFetched());
    for (int i = 0; i < cats.length; i++) {
      if (i <= 5) items1.add(cats[i]);

      if (i > 5 && i < 9) items2.add(cats[i]);

      if (i >= 9) items3.add(cats[i]);
    }
    super.initState();
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

  void changeAudio(String? audio) async {
    if (audio == null) {
      //TODO show alert
    }
    player.stop();

    await player.setAsset(audio!);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        //TODO: call bloc
        child: BlocBuilder<CatBloc, CatState>(
          builder: (context, state) {
            if (state.status == CatStatus.success) {
              return Column(
                children: [
                  _buildTitle('A voice that draws cat to you.', 'assets/home/cat/title_1.png', const Color(0xFFA4AFDC)),
                  const Gap(14),
                  _buildGridview(items1),
                  const Gap(14),
                  _buildTitle('Make your cat love you more.', 'assets/home/cat/title_2.png', const Color(0xFF81CAE7)),
                  const Gap(14),
                  _buildGridview(items2),
                  const Gap(14),
                  _buildTitle('Love your cat is to know them.', 'assets/home/cat/title_3.png', const Color(0xFFE88570)),
                  const Gap(14),
                  _buildGridview(items3),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }

  Widget _buildTitle(String text, String image, Color color) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(28), color: color),
              child: Row(
                children: [const Gap(80), Text(text, style: const TextStyle(color: Colors.white))],
              ),
            ),
          ),
          Positioned(child: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover)),
        ],
      ),
    );
  }

  Widget _buildGridview(List<Animal> cats) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cats.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (MediaQuery.of(context).orientation == Orientation.landscape) ? 5 : 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            IconButton(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                backgroundColor: const Color(0xFFFFC7CB),
                iconSize: 100,
                padding: const EdgeInsets.all(5),
                maximumSize: const Size(200, 200),
                minimumSize: const Size(100, 100),
              ),
              onPressed: () => changeAudio(cats[index].audio),
              icon: Image.asset(fit: BoxFit.contain, cats[index].img, width: 67, height: 80),
            ),
            const Gap(5),
            Text(cats[index].title, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400)),
          ],
        );
      },
    );
  }
}
