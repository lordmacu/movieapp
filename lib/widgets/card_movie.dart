import 'package:flutter/material.dart';
import 'package:movies/models/Movie.dart';
import 'package:star_rating/star_rating.dart';

class CardMovie extends StatefulWidget {
  Movie movie;

  CardMovie({Key key, this.movie}) : super(key: key);

  @override
  _CardMovie createState() => _CardMovie();
}

class _CardMovie extends State<CardMovie> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            child: null,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.movie.image),
                fit: BoxFit.cover,
              ),
            ),
          )),
          Container(
            child: Text(
              "${widget.movie.title}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(top: 5, bottom: 5),
          ),
          Container(
            child: StarRating(
              mainAxisAlignment: MainAxisAlignment.start,
              length: 5,
              rating: widget.movie.rating,
              between: 5.0,
              starSize: 15.0,
              onRaitingTap: (rating) {},
            ),
            margin: EdgeInsets.only(top: 5, bottom: 20),
          )
        ],
      ),
    );
  }
}
