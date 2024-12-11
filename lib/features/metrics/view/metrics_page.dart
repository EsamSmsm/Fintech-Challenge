import 'package:fintech_challenge/core/constants/asstes.dart';
import 'package:fintech_challenge/core/constants/strings.dart';
import 'package:fintech_challenge/features/metrics/cubit/metrics_cubit.dart';
import 'package:fintech_challenge/features/metrics/view/widgets/metrics_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/orders_repo.dart';

class MetricsPage extends StatelessWidget {
  const MetricsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsManager.metricsOverview),
        //if not web
        automaticallyImplyLeading: kIsWeb ? false : true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => MetricsCubit(OrdersRepoImpl())..loadOrders(),
          child: BlocBuilder<MetricsCubit, MetricsState>(
            builder: (context, state) {
              MetricsCubit cubit = context.read<MetricsCubit>();
              return state is OrdersLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.extent(
                      padding: const EdgeInsets.all(10),
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      maxCrossAxisExtent: 450,
                      children: [
                        MetricsCard(
                          title: StringsManager.totalOrders,
                          value: cubit.totalCount,
                          imagePath: AssetManager.orders,
                        ),
                        MetricsCard(
                          title: StringsManager.averagePrice,
                          value: cubit.averagePrice,
                          suffix: ' \$',
                          imagePath: AssetManager.averagePrice,
                        ),
                        MetricsCard(
                          title: StringsManager.returnedOrders,
                          value: cubit.returnsCount,
                          imagePath: AssetManager.returned,
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
