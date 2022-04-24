import 'package:air_quality_application/models/viewmodel.dart';
import 'package:air_quality_application/screens/history/history_screen.dart';
import 'package:air_quality_application/screens/home/home_screen.dart';
import 'package:air_quality_application/screens/recommend/recommend_screen.dart';
import 'package:air_quality_application/screens/tab_routes.dart';
import 'package:air_quality_application/utils/styleguides/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({ Key? key, required this.viewmodel}) : super(key: key);
  final viewmodel;
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 1;
  late final List<Widget> _children;
  final _navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
  };
@override
void initState() {
    super.initState();
     _children = [HistoryScreen(), ChangeNotifierProvider<DataViewModel>( create: (_) => widget.viewmodel,child: HomeScreen()), RecommendScreen()];
}
  Future<bool> _onBackPressed(BuildContext context) async {
    print('onbackpressed');
    FocusScope.of(context).unfocus();
    return !await _navigatorKeys[_currentIndex]!.currentState!.maybePop();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: _buildBody(context),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: Container(
          child: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [darkBlueGradientColor, lightBlueGradientColor])),
        ),
        preferredSize: Size(size.width, 0),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: onTappedBar,
        index: _currentIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: lightBlueGradientColor,
        items: [
          Icon(Icons.stacked_line_chart, size: size.height * 0.04, color: Colors.white,),
          Icon(Icons.home, size: size.height * 0.04, color: Colors.white,),
          Icon(Icons.recommend, size: size.height * 0.04, color: Colors.white,),
        ],
      ),
    );
  }
  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[index]!,
        child: _children[index],
      ),
    );
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        _buildOffstageNavigator(0),
        _buildOffstageNavigator(1),
        _buildOffstageNavigator(2),
      ],
    );
  }
}

