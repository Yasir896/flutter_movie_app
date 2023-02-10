import 'package:flutter_movie_app/src/models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFatcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allMovies => _moviesFatcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFatcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFatcher.close();
  }
}

final bloc = MoviesBloc();