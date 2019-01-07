import 'package:diablo_season_6p/blocs/bloc_provider.dart';
import 'package:diablo_season_6p/blocs/tier_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:diablo_season_6p/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TierBloc bloc = BlocProvider.of<TierBloc>(context);
    bloc.checkChallenge.add('');
    return Scaffold(
      appBar: AppBar(
        title: Text('Season Journey Tracker'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: ListView(
            children: <Widget>[
              Text(
                homeTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                homeMessage,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Builder(
          builder: (context) => ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: ScrollPhysics(parent: PageScrollPhysics()),
                children: _getDrawerItems(context, bloc),
              ),
        ),
      ),
    );
  }

  List<Widget> _getDrawerItems(BuildContext context, TierBloc bloc) {
    var items = <Widget>[];

    items.add(DrawerHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'Total completion',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          StreamBuilder<int>(
              stream: bloc.getAllChecked,
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                double percentage = (snapshot.data / maxChallengesAmount) * 100;
                String percent = percentage.toStringAsFixed(1);
                return Text(
                  '${snapshot.data} / $maxChallengesAmount done ($percent%)',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                );
              }),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    ));

    for (var x = 0; x < routes.length; x++) {
      items.add(ListTile(
        title: Text(routes[x].item2),
        onTap: () {
          Navigator.pushNamed(context, routes[x].item1);
        },
      ));
    }

    return items;
  }
}
