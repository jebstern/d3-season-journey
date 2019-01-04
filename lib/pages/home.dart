import 'package:diablo_season_6p/blocs/bloc_provider.dart';
import 'package:diablo_season_6p/blocs/tier_bloc.dart';
import 'package:diablo_season_6p/db/DBProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:diablo_season_6p/constants.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  HomePageWidget createState() => HomePageWidget();
}

class HomePageWidget extends State<HomePage> {
  final String title;
  var db = DBProvider.singleton;
  int checkedTotal = 0;

  HomePageWidget({Key key, this.title});

  void initState() {
    super.initState();
    initDB();
  }

  @override
  Widget build(BuildContext context) {
    final TierBloc bloc = BlocProvider.of<TierBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Diablo3 seasonal 6P'),
      ),
      body: Container(child: Text('Chapter 1')),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'D3 Season Journey tracker',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          GestureDetector(
            onTap: () {
              updateChecked();
            },
            child: Text(
              'Total completion: $checkedTotal/85',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
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

  Future initDB() async {
    await db.initialize();
  }

  void updateChecked() async {
    int checked = await db.getAllChecked();
    setState(() {
      checkedTotal = checked;
    });
  }
}
