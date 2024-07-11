import 'package:cat_and_dog/features/bloc/app_color_bloc.dart';
import 'package:cat_and_dog/features/dogs/bloc/dog_bloc.dart';
import 'package:cat_and_dog/features/dogs/dogs.dart';
import 'package:cat_and_dog/features/home/data/data.dart';
import 'package:cat_and_dog/features/home/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';

class DogPage extends StatefulWidget {
  const DogPage({super.key});

  @override
  State<DogPage> createState() => _DogPageState();
}

class _DogPageState extends State<DogPage> with WidgetsBindingObserver {
  late AudioPlayer player;
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
    // context.read<DogBloc>().add(DogFetched());
    for (int i = 0; i < dogs.length; i++) {
      if (i <= 5) items1.add(dogs[i]);

      if (i > 5 && i < 9) items2.add(dogs[i]);

      if (i >= 9) items3.add(dogs[i]);
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

    await player.setUrl(audio!);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        //TODO: call bloc
        child: BlocBuilder<DogBloc, DogState>(
          builder: (context, state) {
            if (state.status == DogStatus.success) {
              return Column(
                children: [
                  _buildTitle('A voice that draws dog to you.', 'assets/home/dog/title_1.png', const Color(0xFFA4AFDC)),
                  const Gap(14),
                  _buildGridview(items1),
                  const Gap(14),
                  _buildTitle('Make your dog love you more.', 'assets/home/dog/title_2.png', const Color(0xFF81CAE7)),
                  const Gap(14),
                  _buildGridview(items2),
                  const Gap(14),
                  _buildTitle('Love your dog is to know them.', 'assets/home/dog/title_3.png', const Color(0xFFE88570)),
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

  Widget _buildGridview(List<Animal> dogs) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dogs.length,
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
              onPressed: () => changeAudio(dogs[index].audio),
              icon: Image.asset(fit: BoxFit.contain, dogs[index].img, width: 67, height: 80),
            ),
            const Gap(5),
            Text(dogs[index].title, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400)),
          ],
        );
      },
    );
  }
}
