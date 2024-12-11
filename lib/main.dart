import 'package:fintech_challenge/core/routes/router.dart';
import 'package:fintech_challenge/core/theme/app_theme.dart';
import 'package:fintech_challenge/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/constants/colors.dart';
import 'core/constants/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      title: StringsManager.appTitle,
      theme: AppTheme.theme,
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        elevation: 4,
        title: const Text(
          StringsManager.fintechDashboard,
        ),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            HomeCard(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouter.metricsPage);
              },
              icon: Icons.bar_chart,
              title: StringsManager.viewMetrics,
              subtitle: StringsManager.viewMetricsSubtitle,
            ),
            const SizedBox(height: 16),
            HomeCard(
              icon: Icons.show_chart,
              title: StringsManager.viewGraph,
              subtitle: StringsManager.viewGraphSubtitle,
              onTap: () {
                Navigator.of(context).pushNamed(AppRouter.graphPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
