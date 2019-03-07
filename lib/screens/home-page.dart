import 'package:flutter/material.dart';
import 'package:game_log/data/globals.dart';
import 'package:game_log/screens/edit-log.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String pageTitle = 'GameLog';
  BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.fromLTRB(lrPadding,headerPaddingTop,lrPadding,0),
          child: Column(
            children: [
              Center(
                  child: Text(
                      pageTitle,
                      style: Theme.of(context).textTheme.headline
                  )
              ),
              Spacer(),
              RaisedButton(
                onPressed: _createLog,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                    child: Text('Create Log',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 28.0
                      )
                  )
                ),
                color: Theme.of(context).primaryColor,
              ),
              Spacer()
            ],
          )
        )
    );
  }

  void _createLog() {
    tabIdxController.sink.add(tabs['logs']);
    Navigator.push(_buildContext, MaterialPageRoute(builder: (context) => EditLogPage()));
  }
}