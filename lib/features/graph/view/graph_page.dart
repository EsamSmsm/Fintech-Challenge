import 'package:fintech_challenge/core/constants/colors.dart';
import 'package:fintech_challenge/core/constants/strings.dart';
import 'package:fintech_challenge/features/graph/cubit/graph_cubit.dart';
import 'package:fintech_challenge/features/graph/view/widgets/graph_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsManager.ordersOverTime),
        automaticallyImplyLeading: !kIsWeb,
      ),
      backgroundColor: ColorManager.itemBG,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<GraphCubit, GraphState>(
          builder: (context, state) {
            final ordersData =
                context.read<GraphCubit>().getOrderCountsByDate();
            if (state is OrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return GraphWidget(ordersData: ordersData);
          },
        ),
      ),
    );
  }
}
