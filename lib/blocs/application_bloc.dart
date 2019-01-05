//import 'dart:async';
//import 'package:collection/collection.dart';
import 'package:diablo_season_6p/blocs/bloc_provider.dart';
import 'package:diablo_season_6p/db/DBProvider.dart';

class ApplicationBloc implements BlocBase {
    DBProvider db = DBProvider.singleton;
  /*
  StreamController<List<MovieGenre>> _syncController = StreamController<List<MovieGenre>>.broadcast();
  Stream<List<MovieGenre>> get outMovieGenres => _syncController.stream;

  StreamController<List<MovieGenre>> _cmdController = StreamController<List<MovieGenre>>.broadcast();
  StreamSink get getMovieGenres => _cmdController.sink;
  */

  ApplicationBloc() {
    print('ApplicationBloc - constructor');
    db.initialize();
    // Read all genres from Internet
    /*
    api.movieGenres().then((list) {
      _genresList = list;
    });

    _cmdController.stream.listen((_){
      _syncController.sink.add(UnmodifiableListView<MovieGenre>(_genresList.genres));
    });
    */
  }

  void dispose() {
    // _syncController.close();
    //_cmdController.close();
  }

  // MovieGenresList _genresList;
}
