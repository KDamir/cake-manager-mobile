import 'package:flutter/material.dart';
import 'package:mobile/src/models/cake_order_model.dart';

class OrderDetail extends StatelessWidget {

  final CakeOrderModel model;

  const OrderDetail({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> childrens;

    childrens = <Widget>[
      Text(model.orderName),
      Text(model.decor),
      Text(model.description),
      Text(model.price.toString()),
      Text(model.clientName),
      Text(model.clientContact),
      Text(model.toDateTime.toIso8601String()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(model.orderName),
      ),
      body: Center(
        child: Column(
          children: childrens,
        ),
      ),
    );
  }

}