import 'dart:async';

import 'package:diablo_season_6p/blocs/bloc_provider.dart';
import 'package:diablo_season_6p/db/DBProvider.dart';
import 'package:rxdart/rxdart.dart';

class TierBloc implements BlocBase {
  DBProvider db = DBProvider.singleton;

  StreamController<String> _onChallengeClickedController = StreamController();
  StreamSink get checkChallenge => _onChallengeClickedController.sink;
  StreamController<String> _onTierPageOpenedController = StreamController();
  StreamSink get checkTierChallenges => _onTierPageOpenedController.sink;

  final BehaviorSubject<int> _tierCheckedChallengesSubject = BehaviorSubject<int>();
  Stream<int> get getTierChecked => _tierCheckedChallengesSubject.stream;

  TierBloc() {
    _onChallengeClickedController.stream.listen(_handleLogic);
    _onTierPageOpenedController.stream.listen(_handleChapterLogic);
  }

  Future _handleLogic(title) async {
    int checked = await db.getTierCheckedWithTitle(title);
    _tierCheckedChallengesSubject.add(checked);
  }

  Future _handleChapterLogic(tier) async {
    int checked = await db.getTierChecked(tier);
    _tierCheckedChallengesSubject.add(checked);
  }

  void dispose() {
    _onChallengeClickedController.close();
    _onTierPageOpenedController.close();
    _tierCheckedChallengesSubject.close();
  }
}
