import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OrderRequestModel {
  final String orderName;
  final String buyersAddress;
  //final String uid;

  OrderRequestModel({
    required this.orderName,
    required this.buyersAddress,
  });

  Map<String, dynamic> getJson()=>{
    'orderName': orderName,
    'buyersAddress': buyersAddress,

  };

  factory OrderRequestModel.getModelFromJson({required Map<String, dynamic> json}){
    return OrderRequestModel(orderName: json['orderName'], buyersAddress: json['buyersAddress']);
  }
}
