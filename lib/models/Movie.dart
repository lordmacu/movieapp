class Movie {
  String _title;
  String _id;
  int _rank;
  double _rating;
  String _uid;

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  double get rating => _rating;

  set rating(double value) {
    _rating = value;
  }

  String _image;

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  Movie();

  @override
  String toString() {
    return 'Movie{_title: $_title, _id: $_id, _rank: $_rank, _image: $_image}';
  }

  int get rank => _rank;

  set rank(int value) {
    _rank = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}
