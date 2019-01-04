import 'package:diablo_season_6p/widgets/ChapterWidget.dart';
import 'package:diablo_season_6p/db/DBProvider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  MyHomePageWidget createState() => MyHomePageWidget();
}

class MyHomePageWidget extends State<MyHomePage> {
  final String title;
  DBProvider db = DBProvider();
  int checkedTotal = 0;

  MyHomePageWidget({Key key, this.title});

  void initState() {
    super.initState();
    initDB();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diablo3 seasonal 6P',
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
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
                  children: _getDrawerItems(context),
                ),
          ),
        ),
      ),
      routes: {
        '/chapter1': (context) => ChapterWidget(tier: 'Chapter I'),
        '/chapter2': (context) => ChapterWidget(tier: 'Chapter II'),
        '/chapter3': (context) => ChapterWidget(tier: 'Chapter III'),
        '/chapter4': (context) => ChapterWidget(tier: 'Chapter IV'),
        '/slayer': (context) => ChapterWidget(tier: 'Slayer'),
        '/champion': (context) => ChapterWidget(tier: 'Champion'),
        '/destroyer': (context) => ChapterWidget(tier: 'Destroyer'),
        '/conqueror': (context) => ChapterWidget(tier: 'Conqueror'),
        '/guardian': (context) => ChapterWidget(tier: 'Guardian'),
      },
    );
  }

  List<Widget> _getDrawerItems(BuildContext context) {
    return <Widget>[
      DrawerHeader(
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
      ),
      ListTile(
        title: Text('Chapter 1'),
        onTap: () {
          Navigator.pushNamed(context, '/chapter1');
        },
      ),
      ListTile(
        title: Text('Chapter 2'),
        onTap: () {
          Navigator.pushNamed(context, '/chapter2');
        },
      ),
      ListTile(
        title: Text('Chapter 3'),
        onTap: () {
          Navigator.pushNamed(context, '/chapter3');
        },
      ),
      ListTile(
        title: Text('Chapter 4'),
        onTap: () {
          Navigator.pushNamed(context, '/chapter4');
        },
      ),
      ListTile(
        title: Text('Slayer'),
        onTap: () {
          Navigator.pushNamed(context, '/slayer');
        },
      ),
      ListTile(
        title: Text('Champion'),
        onTap: () {
          Navigator.pushNamed(context, '/champion');
        },
      ),
      ListTile(
        title: Text('Destroyer'),
        onTap: () {
          Navigator.pushNamed(context, '/destroyer');
        },
      ),
      ListTile(
        title: Text('Conqueror'),
        onTap: () {
          Navigator.pushNamed(context, '/conqueror');
        },
      ),
      ListTile(
        title: Text('Guardian'),
        onTap: () {
          Navigator.pushNamed(context, '/guardian');
        },
      ),
    ];
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

  void switchChanged(bool value) {}
}
