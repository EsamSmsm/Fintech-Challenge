part of 'metrics_cubit.dart';

@immutable
sealed class MetricsState {}

final class MetricsInitial extends MetricsState {}

final class OrdersLoading extends MetricsState {}

final class OrdersLoaded extends MetricsState {}

final class OrdersError extends MetricsState {
  final String error;

  OrdersError(this.error);
}
