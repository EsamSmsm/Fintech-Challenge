part of 'graph_cubit.dart';

@immutable
sealed class GraphState {}

final class GraphInitial extends GraphState {}

final class OrdersLoading extends GraphState {}

final class OrdersLoaded extends GraphState {}

final class OrdersError extends GraphState {
  final String error;

  OrdersError(this.error);
}
