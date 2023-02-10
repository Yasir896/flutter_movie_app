import 'package:flutter/material.dart';
import 'package:flutter_movie_app/src/blocs/movie_detail_bloc.dart';
import 'package:flutter_movie_app/src/blocs/movies_bloc.dart';
import 'package:flutter_movie_app/src/ui/movie_detail.dart';

import '../models/item_model.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data?.results.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].poster_path}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailPage(snapshot.data!, index),
            ),
          );
        });
  }

  openDetailPage(ItemModel data, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieDetailBlocProvider(
        child: MovieDetail(
          title: data.results[index].title,
          posterUrl: data.results[index].backdrop_path,
          description: data.results[index].overview,
          releaseDate: data.results[index].release_date,
          voteAverage: data.results[index].vote_average.toString(),
          movieId: data.results[index].id,
        ),
      );
    }));
  }
}

/*
class MoviesList extends StatelessWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: snapshot.data?.results.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          footer: Text("${snapshot.data?.results[index].title}",
          style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.normal
          ),),
          child: Image.network(
            'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].poster_path}',
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
*/
