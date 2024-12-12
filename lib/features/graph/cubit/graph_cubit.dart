import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/order_model.dart';
import '../../../data/repo/orders_repo.dart';

part 'graph_state.dart';

class GraphCubit extends Cubit<GraphState> {
  GraphCubit(this._repo) : super(GraphInitial());

  final OrdersRepo _repo;

  List<OrderModel> orders = [];
  Map<DateTime, int> orderCounts = {};

  /// Fetches orders from the repository and updates the state.
  Future<void> fetchOrders() async {
    try {
      emit(OrdersLoading());
      orders = await _repo.fetchOrders();
      populateOrderCounts();
      emit(OrdersLoaded());
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  /// Populates the orderCounts map with the count of orders by date.
  void populateOrderCounts() {
    orderCounts.clear();
    for (var order in orders) {
      final date = DateTime(
          order.registered.year, order.registered.month, order.registered.day);
      orderCounts[date] = (orderCounts[date] ?? 0) + 1;
    }
  }

  /// Returns the map of order counts by date.
  Map<DateTime, int> getOrderCountsByDate() {
    log(orderCounts.toString());
    return orderCounts;
  }
}
