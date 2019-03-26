import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_log/data/globals.dart';
import 'package:game_log/screens/edit-log-page/edit-log-page.dart';
import 'package:game_log/screens/edit-game-page.dart';
import 'package:game_log/screens/edit-player-page.dart';
import 'package:game_log/screens/view-log-page.dart';
import 'package:game_log/widgets/slide-transition.dart';
import 'package:game_log/data/gameplay.dart';
import 'package:game_log/data/player.dart';
import 'package:game_log/data/game.dart';
import 'package:game_log/screens/settings-page.dart';
import 'routes.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0x00FFFFFF)
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    _getAllPlayers();

    return new MaterialApp(
      title: 'TBGF: GameLog',
      theme: new ThemeData(
        primarySwatch: MaterialColor(0xFF6FCF97,
            {
              50: Color(0xFFCFF6DF),
              100: Color(0xFFCFF6DF),
              200: Color(0xFFCFF6DF),
              300: Color(0xFF9DE5BA),
              400: Color(0xFF9DE5BA),
              500: Color(0xFF6FCF97),
              600: Color(0xFF6FCF97),
              700: Color(0xFF49B675),
              800: Color(0xFF49B675),
              900: Color(0xFF2D9E5B)
            }),
        accentColor: MaterialAccentColor(0xFF6BA6C0,
            {
              50: Color(0xFFCEE8F3),
              100: Color(0xFFCEE8F3),
              200: Color(0xFFCEE8F3),
              300: Color(0xFF9AC9DD),
              400: Color(0xFF9AC9DD),
              500: Color(0xFF6BA6C0),
              600: Color(0xFF6BA6C0),
              700: Color(0xFF45849F),
              800: Color(0xFF45849F),
              900: Color(0xFF2C6E8B)
            }),
        fontFamily: 'Robotto',
        textTheme: TextTheme(
            headline: TextStyle(fontSize: 32.0, color: Colors.black54, fontWeight: FontWeight.w300),
            title: TextStyle(fontSize: 26.0, color: defaultGray, fontWeight: FontWeight.w400),
            body1: TextStyle(fontSize: 16.0, color: defaultBlack, fontWeight: FontWeight.w400),
            button: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w300),
            subtitle: TextStyle(fontSize: 16.0, color: defaultGray, fontWeight:FontWeight.w400)
        )
      ),
      home: MainAppRoutes(),
      onGenerateRoute: (settings) {
        Map<String, dynamic> args = settings.arguments;
        switch (settings.name) {
          case '/': return MaterialPageRoute(builder: (context) => MainAppRoutes());
          case '/edit-log-page': return MaterialPageRoute<GamePlay>(builder: (context) => EditLogPage(gameplay: args['gameplay']));
          case '/edit-game-page': return MaterialPageRoute<Game>(builder: (context) => EditGamePage(game: args['game']));
          case '/edit-player-page': return MaterialPageRoute<Player>(builder: (context) => EditPlayerPage(player: args['player']));
          case '/view-log-page': return SlideRouteTransition<GamePlay>(direction: SlideDirection.Left, widget: ViewLogPage(gameplay: args['gameplay']));
          case '/settings-page': return MaterialPageRoute(builder: (context) => SettingsPage());
        }
      },
    );
  }

  void _getAllPlayers() {
    Firestore.instance.collection('players')
      .getDocuments()
      .then((snapshot) {
        List<Player> dbPlayers = [];
        snapshot.documents.forEach((doc) {
          dbPlayers.add(Player(
            name: doc.data['name'],
            color: Color(doc.data['color']),
            dbRef: doc.reference
          ));
        });
        globalPlayerList = dbPlayers;
      });
  }
}