import 'package:diablo_season_6p/blocs/bloc_provider.dart';
import 'package:diablo_season_6p/db/DBProvider.dart';

class ApplicationBloc implements BlocBase {
  DBProvider db = DBProvider.singleton;

  ApplicationBloc() {
    print('ApplicationBloc - constructor');
    db.initialize();
  }

  void dispose() {}
}
