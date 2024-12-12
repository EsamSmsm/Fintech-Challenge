import 'package:fintech_challenge/data/models/order_model.dart';
import 'package:fintech_challenge/data/repo/orders_repo.dart';
import 'package:fintech_challenge/features/metrics/cubit/metrics_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'test.mocks.dart';

@GenerateMocks([OrdersRepo])
void main() {
  //metrics cubit test
  group('MetricsCubit', () {
    late MetricsCubit metricsCubit;
    late OrdersRepo mockOrdersRepo;

    setUp(() {
      mockOrdersRepo = MockOrdersRepo();
      metricsCubit = MetricsCubit(mockOrdersRepo);
    });

    tearDown(() {
      metricsCubit.close();
    });

    test('initial state is MetricsInitial', () {
      expect(metricsCubit.state, isA<MetricsInitial>());
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
      expectLater(metricsCubit.stream, emitsInOrder(expectedStates));

      await metricsCubit.fetchOrders();
    });

    test('loadOrders emits OrdersLoading and OrdersError on failure',
        () async* {
      when(mockOrdersRepo.fetchOrders())
          .thenThrow(Exception('Failed to load orders'));

      final expectedStates = [
        OrdersLoading(),
        OrdersError('Exception: Failed to load orders')
      ];
      expectLater(metricsCubit.stream, emitsInOrder(expectedStates));

      await metricsCubit.fetchOrders();
    });

    test('totalCount returns correct number of orders', () async {
      final orders = [
        OrderModel(
          id: '1',
          price: 100,
          status: OrderStatus.delivered,
          isActive: true,
          company: 'Company A',
          registered: DateTime.now(),
        ),
        OrderModel(
          id: '2',
          price: 200,
          status: OrderStatus.delivered,
          isActive: true,
          company: 'Company B',
          registered: DateTime.now(),
        )
      ];
      when(mockOrdersRepo.fetchOrders()).thenAnswer((_) async => orders);

      await metricsCubit.fetchOrders();
      expect(metricsCubit.totalCount, 2);
    });

    test('averagePrice returns correct average price', () async {
      final orders = [
        OrderModel(
          id: '1',
          price: 100,
          status: OrderStatus.delivered,
          isActive: true,
          company: 'Company A',
          registered: DateTime.now(),
        ),
        OrderModel(
          id: '2',
          price: 200,
          status: OrderStatus.delivered,
          isActive: true,
          company: 'Company B',
          registered: DateTime.now(),
        )
      ];
      when(mockOrdersRepo.fetchOrders()).thenAnswer((_) async => orders);

      await metricsCubit.fetchOrders();
      expect(metricsCubit.averagePrice, 150);
    });

    test('returnsCount returns correct number of returned orders', () async {
      final orders = [
        OrderModel(
          id: '1',
          price: 100,
          status: OrderStatus.returned,
          isActive: true,
          company: 'Company A',
          registered: DateTime.now(),
        ),
        OrderModel(
          id: '2',
          price: 200,
          status: OrderStatus.delivered,
          isActive: true,
          company: 'Company B',
          registered: DateTime.now(),
        )
      ];
      when(mockOrdersRepo.fetchOrders()).thenAnswer((_) async => orders);

      await metricsCubit.fetchOrders();
      expect(metricsCubit.returnsCount, 1);
    });
  });
}
