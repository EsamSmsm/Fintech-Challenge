import 'dart:developer';

import 'package:fintech_challenge/data/models/order_model.dart';
import 'package:fintech_challenge/data/repo/orders_repo.dart';
import 'package:fintech_challenge/features/graph/cubit/graph_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'test.mocks.dart';

@GenerateMocks([OrdersRepo])
void main() {
  //graph cubit test
  group('GraphCubit', () {
    late GraphCubit graphCubit;
    late OrdersRepo mockOrdersRepo;

    setUp(() {
      mockOrdersRepo = MockOrdersRepo();
      graphCubit = GraphCubit(mockOrdersRepo);
    });

    tearDown(() {
      graphCubit.close();
    });

    test('initial state is GraphInitial', () {
      expect(graphCubit.state, isA<GraphInitial>());
    });

    test('loadOrders emits OrdersLoading and OrdersLoaded on success',
        () async* {
      final orders = [
        OrderModel(
          id: '1',
          price: 100,
          status: OrderStatus.delivered,
          isActive: true,
          company: 'Company A',
          registered: DateTime.now(),
        )
      ];
      when(mockOrdersRepo.fetchOrders()).thenAnswer((_) async => orders);

      final expectedStates = [OrdersLoading(), OrdersLoaded()];
      expectLater(graphCubit.stream, emitsInOrder(expectedStates));

      await graphCubit.fetchOrders();
    });

    test('loadOrders emits OrdersLoading and OrdersError on failure',
        () async* {
      when(mockOrdersRepo.fetchOrders())
          .thenThrow(Exception('Failed to load orders'));

      final expectedStates = [
        OrdersLoading(),
        OrdersError('Exception: Failed to load orders')
      ];
      expectLater(graphCubit.stream, emitsInOrder(expectedStates));

      await graphCubit.fetchOrders();
    });

    test('getOrderCountsByDate handles orders on different days correctly', () {
      graphCubit.orders = [
        OrderModel(
          id: '1',
          price: 100,
          status: OrderStatus.delivered,
          isActive: true,
          company: 'Company A',
          registered: DateTime(2023, 11, 1),
        ),
        OrderModel(
          id: '2',
          price: 150,
          status: OrderStatus.delivered,
          isActive: true,
          company: 'Company B',
          registered: DateTime(2023, 10, 2),
        ),
        OrderModel(
          id: '3',
          price: 250,
          status: OrderStatus.ordered,
          isActive: true,
          company: 'Company c',
          registered: DateTime(2023, 10, 2),
        ),
      ];
      graphCubit.populateOrderCounts();
      final orderCounts = graphCubit.getOrderCountsByDate();
      log(orderCounts.toString());
      expect(orderCounts, {
        DateTime(2023, 11, 1): 1,
        DateTime(2023, 10, 2): 2,
      });
    });
  });
}
