import 'package:flutter_movie_app/src/resources/movie_api_provider.dart';
import '../models/item_model.dart';
import '../models/trailer_model.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMoviesList();

  Future<TrailerModel> fetchTrailers(int movieId) =>
      moviesApiProvider.fetchTrailer(movieId);

}