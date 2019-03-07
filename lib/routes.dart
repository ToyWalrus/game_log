import 'package:flutter/material.dart';
import 'package:game_log/screens/home-page.dart';
import 'package:game_log/screens/logs-page.dart';
import 'package:game_log/screens/settings-page.dart';
import 'package:game_log/data/globals.dart';

class MainAppRoutes extends StatefulWidget {
  MainAppRoutes({Key key}) : super(key: key);

  @override
  _MainAppRoutesState createState() => _MainAppRoutesState();
}

class _MainAppRoutesState extends State<MainAppRoutes> {
  int _tabIdx;
  Widget _currentPage;
  List<Widget> _mainPages;
  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Settings'),),
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
    BottomNavigationBarItem(icon: Icon(Icons.view_list), title: Text('Logs'))
  ];

  @override
  void initState() {
    _mainPages = [
      SettingsPage(),
      HomePage(),
      LogsPage()
    ];

    _tabIdx = 1;
    _currentPage = _mainPages[_tabIdx];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<int>(
            stream: tabIdxController.stream,
            initialData: _tabIdx,
            builder: (BuildContext context, AsyncSnapshot<int> newIdx){
              _tabIdx = newIdx.data;
              _currentPage = _mainPages[_tabIdx];
              return _currentPage;
            }
        ),
        bottomNavigationBar: StreamBuilder<int>(
            stream: tabIdxController.stream,
            initialData: _tabIdx,
            builder: (BuildContext context, AsyncSnapshot<int> newIdx){
              // Put this inside a streambuilder so it forces re-render
              // on new item added to stream
              return BottomNavigationBar(
                  items: _items,
                  currentIndex: _tabIdx,
                  onTap: _updateTab
              );
            }
        )
    );
  }

  void _updateTab(int idx) {
    tabIdxController.sink.add(idx);
  }
}