import 'package:fintech_challenge/main.dart';
import 'package:flutter/material.dart';

import '../../features/graph/view/graph_page.dart';
import '../../features/metrics/view/metrics_page.dart';

class AppRouter {
  static const String homePage = '/';
  static const String metricsPage = '/metrics';
  static const String graphPage = '/graph';

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case metricsPage:
        return MaterialPageRoute(builder: (_) => const MetricsPage());
      case graphPage:
        return MaterialPageRoute(builder: (_) => const GraphPage());
    }
    return null;
  }
}
