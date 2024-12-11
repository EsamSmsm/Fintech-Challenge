import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/order_model.dart';
import '../../../data/repo/orders_repo.dart';

part 'metrics_state.dart';

class MetricsCubit extends Cubit<MetricsState> {
  MetricsCubit(this.repo) : super(MetricsInitial());

  final OrdersRepo repo;

  List<OrderModel> orders = [];

  Future<void> loadOrders() async {
    try {
      emit(OrdersLoading());
      orders = await repo.fetchOrders();
      emit(OrdersLoaded());
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  int get totalCount => orders.length;

  double get averagePrice =>
      orders.map((order) => order.price).reduce((a, b) => a + b) /
      orders.length;

  int get returnsCount =>
      orders.where((order) => order.status == OrderStatus.returned).length;
}
