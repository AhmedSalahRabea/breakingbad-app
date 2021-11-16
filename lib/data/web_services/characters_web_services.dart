import '../../constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 40 * 1000, //40 seconds
      receiveTimeout: 40 * 1000, //40 seconds

    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    Response response = await dio.get('characters');
    try {
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    Response response =
        await dio.get('quote', queryParameters: {'author': charName});
    try {
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
