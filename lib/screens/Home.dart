import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hygge/screens/play_music.dart';
import 'package:hygge/viewmodels/home_vm.dart';

import '../config/colors.dart';

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModel);

    ref.listen<HomeViewModel>(homeViewModel,
        (HomeViewModel? oldVm, HomeViewModel newVm) {
      if (newVm.success) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayMusic(songData: newVm.currentSong),
            ));
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: bgColor,
        elevation: 0.0,
        title: const Text(
          "Speech to Text",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            AvatarGlow(
              animate: vm.isRecognizing,
              glowColor: bgColor,
              endRadius: 75.0,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 100),
              child: GestureDetector(
                onTap: () => vm.isRecognizing
                    ? vm.stopRecognizing()
                    : vm.startRecognizing(),
                child: const CircleAvatar(
                  backgroundColor: bgColor,
                  radius: 35,
                  child: Icon(
                    Icons.music_note,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
