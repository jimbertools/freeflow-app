import 'package:flutter/material.dart';
import 'package:freeflow/app.dart';
// import 'package:app/apps/wallet/wallet.dart';
// import 'package:app/screens/planetary_network_screen.dart';

// import 'apps/farmers/farmers.dart';
// import 'apps/news/news.dart';

class AppInfo {
  Route route;
  App? app;

  AppInfo({required this.route,  this.app});
}

class JRouter {
  List<AppInfo> routes = [];

  init() async {
    routes = [
    //   AppInfo(
    //       route: Route(
    //         path: '/',
    //         name: 'Home',
    //         icon: Icons.home,
    //         view: RegisteredScreen(),
    //       ),
    //       app: null),
    //   AppInfo(
    //       route: Route(
    //         path: '/news',
    //         name: 'News',
    //         icon: Icons.article,
    //         view: await News().widget(),
    //       ),
    //       app: News()),
    ];
  }

  Map<String, Widget Function(BuildContext)> getRoutes() {
    return Map.fromIterable(routes, key: (v) => v.path, value: (v) => v.view);
  }

  bool emailMustBeVerified(int index) {
    if (routes[index].app != null) {
      return routes[index].app!.emailVerificationRequired();
    }
    return false;
  }

  bool pinRequired(int index) {
    if (routes[index].app != null) {
      return routes[index].app!.pinRequired();
    }
    return false;
  }

  List<Widget> getContent() {
    List<Widget> containers = [];
    routes.forEach((r) {
      containers.add(r.route.view);
    });
    return containers;
  }

  List<Container> getAppButtons() {
    List<Container> iconButtons = [];
    routes.forEach((r) {
      iconButtons.add(Container(
          child: Tab(
        icon: Icon(
          r.route.icon,
          size: 40,
        ),
        text: r.route.name,
      )));
    });
    return iconButtons;
  }
}

class Route {
  final IconData icon;
  final String name;
  final String path;
  final Widget view;

  Route({required this.path, required this.name, required this.icon, required this.view});
}
