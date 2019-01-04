import 'package:diablo_season_6p/db/ChallengeModel.dart';
import 'package:diablo_season_6p/db/TierModel.dart';
import 'package:diablo_season_6p/widgets/ChallengeWidget.dart';
import 'package:diablo_season_6p/db/DBProvider.dart';
import 'package:flutter/material.dart';

class ChapterWidget extends StatefulWidget {
  final String tier;

  ChapterWidget({@required this.tier});

  @override
  ChapterWidgetState createState() => ChapterWidgetState(tier);
}

class ChapterWidgetState extends State<ChapterWidget> {
  final String tier;
  String challengesAmount = '';
  int checkedAmount = 0;
  List<ChallengeWidget> challengesList = List();
  String reward = '';
  DBProvider db = DBProvider();

  ChapterWidgetState(this.tier);

  void initState() {
    super.initState();
    getChallenges();
    getTierChecked();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.tier + ': $checkedAmount/$challengesAmount'),
        ),
        body: TabBarView(
          children: [
            new Container(
              color: Colors.white,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: challengesList == null ? 0 : challengesList.length,
                padding: EdgeInsets.all(12),
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  // childAspectRatio: 1.6,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return challengesList[index];
                },
              ),
            ),
            new Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  '$reward',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: new TabBar(
          tabs: [
            Tab(
              child: Text(
                'Challenges',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Rewards',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.redAccent,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }

  void getChallenges() async {
    List<Map> list = await db.getChallengesFromTier(tier);
    for (var x = 0; x < list.length; x++) {
      Challenge challenge = Challenge.fromMap(list[x]);
      challengesList.add(ChallengeWidget(
        title: challenge.title,
        isCompleted: challenge.isCompleted,
        onChallengeClicked: getTierChecked,
      ));
    }

    String tierReward = await db.getTierRewards(tier);

    setState(() {
      challengesAmount = challengesList.length.toString();
      reward = tierReward;
    });
  }

  getTierChecked() async {
    int amount = await db.getTierChecked(tier);
    setState(() {
      checkedAmount = amount;
    });
  }
}
