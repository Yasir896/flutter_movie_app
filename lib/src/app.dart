import 'package:flutter/material.dart';
import 'package:flutter_movie_app/src/ui/movies_list.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: MovieList()
      ),
    );
  }
}
