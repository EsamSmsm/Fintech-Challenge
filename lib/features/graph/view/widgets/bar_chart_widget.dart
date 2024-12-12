import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    super.key,
    required this.ordersData,
  });

  final Map<DateTime, int> ordersData;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        title: const AxisTitle(text: StringsManager.time),
        dateFormat: DateFormat.MMMd(),
        intervalType: DateTimeIntervalType.days,
      ),
      primaryYAxis: NumericAxis(
        title: const AxisTitle(text: StringsManager.ordersCount),
        numberFormat: NumberFormat('##0', 'en_US'),
        autoScrollingMode: AutoScrollingMode.start,
        rangePadding: ChartRangePadding.auto,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      enableAxisAnimation: true,
      title: const ChartTitle(text: StringsManager.ordersOverTime),
      zoomPanBehavior: ZoomPanBehavior(
          enableDoubleTapZooming: true,
          enableMouseWheelZooming: true,
          enablePanning: true,
          zoomMode: ZoomMode.x),
      isTransposed: true,
      series: <CartesianSeries>[
        BarSeries<MapEntry<DateTime, int>, DateTime>(
          dataSource: ordersData.entries.toList(),
          xValueMapper: (MapEntry<DateTime, int> data, _) => data.key,
          yValueMapper: (MapEntry<DateTime, int> data, _) => data.value,
          name: StringsManager.orders,
          pointColorMapper: (datum, index) {
            final average =
                ordersData.values.reduce((a, b) => a + b) / ordersData.length;
            if (datum.value > average) {
              return ColorManager.primary;
            } else {
              return ColorManager.secondary;
            }
          },
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
          ),
        ),
      ],
    );
  }
}
