import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie.dart';
import 'package:movies/models/Movie.dart';

class MoviesServices {
  static updateMovieRanting(FirebaseFirestore firestore, id, rating) async {
    firestore.collection('movies').doc(id).update({"rating": rating});
  }

  static getMovies(firestore) async {
    final movieCtrl = Get.find<MovieController>();

    if (!movieCtrl.hasMore.value) {
      print('No More movies');
      return;
    }
    if (movieCtrl.isLoading.value) {
      return;
    }
    movieCtrl.isLoading.value = true;

    QuerySnapshot querySnapshot;
    if (movieCtrl.lastDocument.value == null) {
      querySnapshot = await firestore
          .collection('movies')
          .orderBy('rank')
          .limit(movieCtrl.documentLimit.value)
          .get();
    } else {
      querySnapshot = await firestore
          .collection('movies')
          .orderBy('rank')
          .startAfterDocument(movieCtrl.lastDocument.value)
          .limit(movieCtrl.documentLimit.value)
          .get();
    }
    if (querySnapshot.docs.length < movieCtrl.documentLimit.value) {
      movieCtrl.hasMore.value = false;
    }
    movieCtrl.lastDocument.value =
        querySnapshot.docs[querySnapshot.docs.length - 1];

    List<Movie> movies = [];
    querySnapshot.docs.forEach((element) {
      Movie movie = Movie();
      movie.id = element.get("id");
      movie.rank = int.parse(element.get("rank"));
      movie.rating = element.get("rating").toDouble();
      movie.image = element.get("image");
      movie.title = element.get("title");
      movie.uid = element.id;
      movies.add(movie);
    });
    movieCtrl.movies.addAll(movies);

    movieCtrl.isLoading.value = false;
  }
}
