import 'package:flutter/material.dart';
import 'package:mobile/src/models/cake_order_model.dart';
import 'package:mobile/src/widgets/ck_order_list_view.dart';
import 'package:mobile/src/pages/add_order_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'order_detail.dart';
import 'package:mobile/src/auth_provider.dart';

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
      builder: (BuildContext context) => AddOrderDialog(),
      fullscreenDialog: true,
    ));
  }

  void showOrder(CakeOrderModel model) {
    Navigator.push(context, MaterialPageRoute<DismissDialogAction>(
      builder: (BuildContext context) => OrderDetail(model: model),
      fullscreenDialog: true,
    ));
  }

  Stream ordersStream() => Firestore.instance
    .collection('cake-orders').where('userId', isEqualTo: userId).snapshots();

  Widget buildBody() => StreamBuilder(
    stream: ordersStream(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const Text('Loading...');
      return new CkOrdersListView(
        child: snapshot,
        showOrder: showOrder,
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: buildBody(),
      floatingActionButton: new FloatingActionButton(
        onPressed: openDialog,
        tooltip: 'Add new order for cake',
        child: new Icon(Icons.add),
      ),
    );
  }
}