import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:movies/models/Movie.dart';

class MovieController extends GetxController {
  Rx<Movie> movie = Movie().obs;
  var movies = [].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var documentLimit = 10.obs;
  var lastDocument = Rx<QueryDocumentSnapshot>();

  var ratingR = 0.0.obs;

  void updateMovieRating(rating) {
    Movie movieCopy = movie.value;
    movieCopy.rating = rating.toDouble();
    movie.value = movieCopy;

    final index =
        movies.indexWhere((element) => element.uid == movie.value.uid);
    movies[index] = movie.value;
    update();
  }
}
