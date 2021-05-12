import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie.dart';
import 'package:movies/services/movies.dart';
import 'package:movies/widgets/list_movies_grid.dart';

class ListMovies extends StatefulWidget {
  ListMovies({Key key}) : super(key: key);

  @override
  _ListMovies createState() => _ListMovies();
}

class _ListMovies extends State<ListMovies> {
  final movieCtrl = Get.put(MovieController());
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ScrollController _scrollController =
      ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MoviesServices.getMovies(firestore);

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        MoviesServices.getMovies(firestore);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${context.getString('latestMovies')}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: ListMoviesGrid(
        scroll: _scrollController,
      ),
    );
  }
}
