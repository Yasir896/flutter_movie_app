import 'package:flutter/material.dart';
import 'package:flutter_movie_app/src/models/trailer_model.dart';
import 'package:flutter_movie_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBlocProvider extends InheritedWidget {
  final MovieDetailBloc bloc;

  MovieDetailBlocProvider({ Key? key, required Widget child,})
      : bloc = MovieDetailBloc(),
        super(key: key, child: child);

  static MovieDetailBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<MovieDetailBlocProvider>()
    as MovieDetailBlocProvider)
        .bloc;
  }

  @override
  bool updateShouldNotify(_) {
    return true;
  }
}


class MovieDetailBloc {
  final _repository = Repository();
  final _movieId = PublishSubject<int>();
  final _trailers = BehaviorSubject<Future<TrailerModel>>();

  Function(int) get fetchTrailerById => _movieId.sink.add;
  Observable<Future<TrailerModel>> get moviesTrailers => _trailers.stream;

  MovieDetailBloc() {
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
        (Future<TrailerModel> trailer, int id, int index) {
          print(index);
          trailer = _repository.fetchTrailers(id);
          return trailer;
        }
    );
  }
}