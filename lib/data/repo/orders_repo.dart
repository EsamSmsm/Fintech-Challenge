// lib/data/repo/orders_repo.dart
import 'dart:convert';

import 'package:fintech_challenge/core/constants/asstes.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/order_model.dart';

abstract class OrdersRepo {
  Future<List<OrderModel>> fetchOrders();
}

class OrdersRepoImpl implements OrdersRepo {
  @override
  Future<List<OrderModel>> fetchOrders() async {
    final String response =
        await rootBundle.loadString(AssetManager.dataSource);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => OrderModel.fromJson(json)).toList();
  }
}
