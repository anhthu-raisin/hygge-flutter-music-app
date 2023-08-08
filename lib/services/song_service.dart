import 'package:dio/dio.dart';
import 'package:hygge/services/models/song_model.dart';

class SongService {
  late Dio _dio;

  SongService() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://api.deezer.com/track/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    _dio = Dio(options);
  }

  Future<HyggeSongModel> getTrack(id) async {
    print("id: " + id);
    try {
      final response = await _dio.get('$id',
          options: Options(headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'Accept': 'application/json;charset=UTF-8',
          }));
      HyggeSongModel result = HyggeSongModel.fromJson(response.data);
      return result;
    } on DioException catch (e) {
      if (e.response != null) {
        throw 'An error has occured';
      } else {
        throw 'e.error';
      }
    }
  }
}
