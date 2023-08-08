import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hygge/services/models/song_model.dart';
import 'package:hygge/services/song_service.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    initAcr();
  }

  final AcrCloudSdk acr = AcrCloudSdk();
  final songService = SongService();
  late HyggeSongModel currentSong;
  bool isRecognizing = false;
  bool success = false;

  Future<void> initAcr() async {
    try {
      acr
        ..init(
          host:
              'identify-ap-southeast-1.acrcloud.com', // obtain from https://www.acrcloud.com/
          accessKey:
              'af1ae236d622eb843cf7d065520a0f6e', // obtain from https://www.acrcloud.com/
          accessSecret:
              'n2cilMvBMr85V0vXceh72hXiCyCcvsv6nrIN3koD', // obtain from https://www.acrcloud.com/
          setLog: true,
        )
        ..songModelStream.listen(searchSong);
    } catch (e) {
      print(e.toString());
    }
  }

  void searchSong(SongModel song) async {
    final metaData = song.metadata;

    if (metaData != null && metaData.music!.isNotEmpty) {
      final trackId = metaData.music![0].externalMetadata?.deezer?.track?.id;

      try {
        final res = await songService.getTrack(trackId);
        currentSong = res;
        success = true;
        notifyListeners();
      } catch (e) {
        isRecognizing = false;
        success = false;
        notifyListeners();
      }
    }
  }

  Future<void> startRecognizing() async {
    isRecognizing = true;
    success = false;
    notifyListeners();
    try {
      await acr.start();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> stopRecognizing() async {
    isRecognizing = false;
    success = false;
    notifyListeners();
    try {
      await acr.stop();
    } catch (e) {
      print(e.toString());
    }
  }
}

final homeViewModel = ChangeNotifierProvider<HomeViewModel>((ref) {
  print('>>> In homeViewModel');
  return HomeViewModel();
});
