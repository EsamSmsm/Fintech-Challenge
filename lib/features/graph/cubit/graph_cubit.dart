import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/order_model.dart';
import '../../../data/repo/orders_repo.dart';

part 'graph_state.dart';

class GraphCubit extends Cubit<GraphState> {
  GraphCubit(this._repo) : super(GraphInitial());

  final OrdersRepo _repo;

  List<OrderModel> orders = [];

  Future<void> fetchOrders() async {
    try {
      emit(OrdersLoading());
      orders = await _repo.fetchOrders();
      emit(OrdersLoaded());
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Map<DateTime, int> getOrderCountsByDate() {
    final Map<DateTime, int> orderCounts = {};
    for (var order in orders) {
      final date = DateTime(
          order.registered.year, order.registered.month, order.registered.day);
      orderCounts[date] = (orderCounts[date] ?? 0) + 1;
    }

    return orderCounts;
  }
}
