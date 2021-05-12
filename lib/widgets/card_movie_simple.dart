import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie.dart';
import 'package:movies/services/movies.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:star_rating/star_rating.dart';

class CardMovieSimple extends StatefulWidget {

  PanelController controller;
  CardMovieSimple(this.controller);

  @override
  _CardMovieSimple createState() => _CardMovieSimple();
}

class _CardMovieSimple extends State<CardMovieSimple> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  MovieController movieCtrl = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieCtrl = Get.find<MovieController>();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() => movieCtrl.movie.value.image != null
        ? Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){

                    widget.controller.close();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios,color: Colors.white,)
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    movieCtrl.movie.value.image != null
                        ? Image.network(
                            movieCtrl.movie.value.image,
                            width: 150,
                          )
                        : Container(),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              movieCtrl.movie.value.title,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "${context.getString('latestMovies')} ${movieCtrl.movie.value.rank}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      StarRating(
                        mainAxisAlignment: MainAxisAlignment.start,
                        length: 5,
                        rating: movieCtrl.movie.value.rating.toDouble(),
                        between: 5.0,
                        starSize: 40.0,
                        onRaitingTap: (rating) {
                          MoviesServices.updateMovieRanting(
                              firestore, movieCtrl.movie.value.uid, rating);

                          movieCtrl.updateMovieRating(rating);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        : Container());
  }
}
