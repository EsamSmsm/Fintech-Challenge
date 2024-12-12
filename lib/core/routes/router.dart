import 'package:fintech_challenge/features/graph/cubit/graph_cubit.dart';
import 'package:fintech_challenge/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/orders_repo.dart';
import '../../features/graph/view/graph_page.dart';
import '../../features/metrics/cubit/metrics_cubit.dart';
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
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      MetricsCubit(OrdersRepoImpl())..fetchOrders(),
                  child: const MetricsPage(),
                ));
      case graphPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => GraphCubit(OrdersRepoImpl())
                    ..fetchOrders()
                    ..fetchOrders(),
                  child: const GraphPage(),
                ));
    }
    return null;
  }
}
