import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  TabNavigator({required this.navigatorKey, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }

  void _push(BuildContext context) {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => SettingScreen()));
  }
}
