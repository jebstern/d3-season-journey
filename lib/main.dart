import 'package:diablo_season_6p/blocs/application_bloc.dart';
import 'package:diablo_season_6p/blocs/bloc_provider.dart';
import 'package:diablo_season_6p/blocs/tier_bloc.dart';
import 'package:diablo_season_6p/pages/home.dart';
import 'package:diablo_season_6p/constants.dart';
import 'package:diablo_season_6p/widgets/ChapterWidget.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  return runApp(BlocProvider<ApplicationBloc>(
    bloc: ApplicationBloc(),
    child: BlocProvider<TierBloc>(
      bloc: TierBloc(),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D3 Season journey tracker',
      theme: ThemeData(fontFamily: 'Exocet'),
      home: HomePage(),
      routes: {
        routes[0].item1: (context) => ChapterWidget(tier: routes[0].item2),
        routes[1].item1: (context) => ChapterWidget(tier: routes[1].item2),
        routes[2].item1: (context) => ChapterWidget(tier: routes[2].item2),
        routes[3].item1: (context) => ChapterWidget(tier: routes[3].item2),
        routes[4].item1: (context) => ChapterWidget(tier: routes[4].item2),
        routes[5].item1: (context) => ChapterWidget(tier: routes[5].item2),
        routes[6].item1: (context) => ChapterWidget(tier: routes[6].item2),
        routes[7].item1: (context) => ChapterWidget(tier: routes[7].item2),
        routes[8].item1: (context) => ChapterWidget(tier: routes[8].item2),
      },
    );
  }
}
