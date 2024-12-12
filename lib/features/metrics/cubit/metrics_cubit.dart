import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/order_model.dart';
import '../../../data/repo/orders_repo.dart';

part 'metrics_state.dart';

class MetricsCubit extends Cubit<MetricsState> {
  MetricsCubit(this._repo) : super(MetricsInitial());

  final OrdersRepo _repo;

  /// List of orders fetched from the repository.
  List<OrderModel> orders = [];

  /// Fetches orders from the repository and updates the state.
  Future<void> fetchOrders() async {
    try {
      emit(OrdersLoading());
      orders = await _repo.fetchOrders();
      emit(OrdersLoaded());
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  /// Returns the total count of orders.
  int get totalCount => orders.length;

  /// Returns the average price of all orders.
  double get averagePrice =>
      orders.map((order) => order.price).reduce((a, b) => a + b) /
      orders.length;

  /// Returns the count of orders that have been returned.
  int get returnsCount =>
      orders.where((order) => order.status == OrderStatus.returned).length;
}
