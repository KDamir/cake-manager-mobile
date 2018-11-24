import 'package:flutter/material.dart';
import 'package:mobile/src/models/cake_card.dart';
import 'package:mobile/src/models/cake_order_model.dart';


class CkOrdersListView extends StatelessWidget {
  final AsyncSnapshot<dynamic> child;
  final Function showOrder;
  const CkOrdersListView({Key key, this.child, this.showOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: child.data.documents.length,
        itemBuilder: (context, int index) {
          CakeOrderModel cakeModel = CakeOrderModel.fromDoc(child.data.documents[index]);
          return CakeCard(
            title: cakeModel.orderName,
            description: cakeModel.description,
            onPress: () => showOrder(cakeModel),
          );
        }
    );
  }

}