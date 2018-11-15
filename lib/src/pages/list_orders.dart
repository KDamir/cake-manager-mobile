import 'package:flutter/material.dart';
import '../cake_order_model.dart';
import '../api_provider.dart';
import '../add_dialog.dart';
import '../cake_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth.dart';
import 'order_detail.dart';
import 'dart:developer';

class ListOrders extends StatefulWidget {
  final BaseAuth auth;

  ListOrders(this.auth);

  @override
  _ListOrdersState createState() => new _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  List<CakeOrderModel> orders = new List();
  ApiProvider apiProvider = new ApiProvider();
  String userId;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((id) {
      setState(() {
        userId = id;
      });
    });
//    apiProvider.fetchCakeOrders().then((result) {
//      setState(() {
//        orders = result.results;
//      });
//    });
  }

  updateState() {
//    apiProvider.fetchCakeOrders().then((result) {
//      setState(() {
//        orders = result.results;
//      });
//    });
  }

  void openDialog() {
    Navigator.push(context, MaterialPageRoute<DismissDialogAction>(
      builder: (BuildContext context) => AddDialog(updateState : updateState),
      fullscreenDialog: true,
    ));
  }

  void showOrder(CakeOrderModel model) {
    Navigator.push(context, MaterialPageRoute<DismissDialogAction>(
      builder: (BuildContext context) => OrderDetail(model: model),
      fullscreenDialog: true,
    ));
  }

  Widget cakeItem(BuildContext context, int index, AsyncSnapshot snapshot) {
    return CakeCard(
      title: snapshot.data.documents[index].data['name'],
      description: snapshot.data.documents[index].data['description'],
    );
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