import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final String id;
  final bool isActive;
  final num price;
  final String company;
  final OrderStatus status;
  final DateTime registered;

  const OrderModel({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required this.status,
    required this.registered,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      isActive: json['isActive'],
      price: num.parse(json['price'].replaceAll(RegExp(r'[^\d.]'), '')),
      company: json['company'],
      status: OrderStatus.fromString(json['status']),
      registered: DateTime.parse(json['registered']),
    );
  }

  @override
  List<Object?> get props => [id, isActive, price, company, status, registered];
}

enum OrderStatus {
  ordered,
  delivered,
  returned;

  factory OrderStatus.fromString(String value) {
    switch (value.toLowerCase()) {
      case 'ordered':
        return OrderStatus.ordered;
      case 'delivered':
        return OrderStatus.delivered;
      case 'returned':
        return OrderStatus.returned;
      default:
        return OrderStatus.ordered;
    }
  }
}
