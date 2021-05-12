import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie.dart';
import 'package:movies/helpers/app_colors.dart';
import 'package:movies/models/Movie.dart';
import 'package:movies/widgets/card_movie.dart';
import 'package:movies/widgets/card_movie_simple.dart';
import 'package:movies/widgets/loading.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ListMoviesGrid extends StatefulWidget {
  ScrollController scroll = null;

  ListMoviesGrid({this.scroll});

  @override
  _ListMoviesGrid createState() => _ListMoviesGrid();
}

class _ListMoviesGrid extends State<ListMoviesGrid> {
  final movieCtrl = Get.find<MovieController>();
  PanelController _controller = null;
  Movie movieIndividual;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Obx(() => SlidingUpPanel(
          controller: _controller,
          panel: Container(
            decoration: BoxDecoration(
              color: AppColors.backColor,
            ),
            child: CardMovieSimple(_controller),
          ),
          minHeight: 0,
          maxHeight: height - 100,
          backdropEnabled: true,
          body: Container(
            child: Column(
              children: [
                Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                        controller: widget.scroll,
                        childAspectRatio: 0.5,
                        children: List.generate(
                          movieCtrl.movies.length,
                          (index) {
                            Movie movie = movieCtrl.movies[index];
                            return GestureDetector(
                              onTap: () {
                                movieCtrl.movie.value = movie;
                                _controller.open();
                              },
                              child: CardMovie(
                                movie: movie,
                              ),
                            );
                          },
                        ))),
                movieCtrl.isLoading.value ? Loading() : Container()
              ],
            ),
          ),
        ));
  }
}
