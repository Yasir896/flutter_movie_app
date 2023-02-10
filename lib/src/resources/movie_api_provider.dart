import 'dart:convert';
import 'package:http/http.dart';
import '../models/item_model.dart';
import '../models/trailer_model.dart';

class MovieApiProvider {

    Client client = Client();
    final _apiKey = "52577e7ae3a086197e871c8041c6e48b";
    final baseUrl = "http://api.themoviedb.org/3/movie";

    Future<ItemModel> fetchMoviesList() async {
      print("enterd");
      final response = await client.get("$baseUrl/popular?api_key=$_apiKey");
      print(response.body.toString());
      if (response.statusCode == 200) {
        return ItemModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    }

    Future<TrailerModel> fetchTrailer(int movieId) async {
      final response = await client.get("$baseUrl/$movieId/videos?api_key=$_apiKey");
      if (response.statusCode == 200) {
        return TrailerModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to Load Trailers');
      }
    }
}