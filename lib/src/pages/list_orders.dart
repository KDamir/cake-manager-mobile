import 'package:flutter/material.dart';
import '../cake_order_model.dart';
import '../api_provider.dart';
import '../add_dialog.dart';
import '../cake_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth.dart';
import 'order_detail.dart';
import 'package:mobile/src/auth_provider.dart';
import 'dart:developer';

class ListOrders extends StatefulWidget {
  @override
  _ListOrdersState createState() => new _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  List<CakeOrderModel> orders = new List();
  String userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fillUserId();
  }

  fillUserId() {
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then((id) {
      userId = id;
    });
  }

  void openDialog() {
    Navigator.push(context, MaterialPageRoute<DismissDialogAction>(
      builder: (BuildContext context) => AddDialog(),
      fullscreenDialog: true,
    ));
  }

  void showOrder(CakeOrderModel model) {
    Navigator.push(context, MaterialPageRoute<DismissDialogAction>(
      builder: (BuildContext context) => OrderDetail(model: model),
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('cake-orders').where('userId', isEqualTo: userId).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, int index) {
                CakeOrderModel cakeModel = CakeOrderModel
                    .fromDoc(snapshot.data.documents[index]);
                // debugger();
                return CakeCard(
                  title: cakeModel.orderName,
                  description: cakeModel.description,
                  onPress: () => showOrder(cakeModel),
                );
              }
            );
          },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: openDialog,
        tooltip: 'Add new order for cake',
        child: new Icon(Icons.add),
      ),
    );
  }
}