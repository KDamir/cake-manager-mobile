import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/src/api_provider.dart';

import 'package:mobile/src/models/cake_order_model.dart';
import 'package:mobile/src/widgets/ck_text_field.dart';
import 'package:mobile/src/widgets/ck_date_column.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/src/auth_provider.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class AddOrderDialog extends StatefulWidget {
  @override
  AddOrderDialogState createState() => AddOrderDialogState();
}

class AddOrderDialogState extends State<AddOrderDialog> {
  bool _saveNeeded = false;
  bool _hasDecor = false;
  bool _hasName = false;
  CakeOrderModel model = new CakeOrderModel();

  final clientNameController = TextEditingController();
  final clientContactController = TextEditingController();
  final priceController = TextEditingController();

  ApiProvider apiProvider = new ApiProvider();
  String _userId;
  CollectionReference get orders => Firestore.instance.collection('cake-orders');

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then((id) {
      _userId = id;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    clientNameController.dispose();
    clientContactController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    _saveNeeded = _hasDecor || _hasName || _saveNeeded;
    if (!_saveNeeded)
      return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'Discard new event?',
            style: dialogTextStyle
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(false); // Pops the confirmation dialog but not the page.
              }
            ),
            FlatButton(
              child: const Text('DISCARD'),
              onPressed: () {
                Navigator.of(context).pop(true); // Returning true to _onWillPop will pop again.
              }
            )
          ],
        );
      },
    ) ?? false;
  }

  nextScreen() {
    setState(() {
      _firstScreen = false;
    });
  }

  save() async {
    await _addOrder();
    Navigator.pop(context, DismissDialogAction.save);
  }

  Future<void> _addOrder() async {
    model.userId = _userId;
    await orders.add(model.toJson());
  }

  onChangeOrderName(String value) {
    setState(() {
      _hasName = value.isNotEmpty;
      if (_hasName) {
        model.orderName = value;
      }
    });
  }

  onChangeDecor(String value) {
    setState(() {
      _hasDecor = value.isNotEmpty;
      if (_hasDecor) {
        model.decor = value;
      }
    });
  }

  onChangeDescription(String value) {
    setState(() {
      if (value.isNotEmpty) {
        model.description = value;
      }
    });
  }

  onChangeClientName(String value) {
    setState(() {
      if (value.isNotEmpty) {
        model.clientName = value;
      }
    });
  }

  onChangeClientContact(String value) {
    setState(() {
      if (value.isNotEmpty) {
        model.clientContact = value;
      }
    });
  }

  onChangePrice(String value) {
    setState(() {
      if (value.isNotEmpty) {
        model.price = double.parse(value);
      }
    });
  }

  onChangeDateTime(DateTime value) {
    setState(() {
      model.toDateTime = value;
      _saveNeeded = true;
    });
  }

  List<Widget> firstScreen() {
    ThemeData theme = Theme.of(context);
    return <Widget>[
      CkTextField(
        label: 'Название заказа',
        style: theme.textTheme.headline,
        onchange: onChangeOrderName,
      ),
      CkTextField(
        label: 'Оформление',
        hint: 'Какое оформление?',
        onchange: onChangeDecor,
      ),
      DateTimeColumn(
        style: theme.textTheme.caption,
        dateTime: model.toDateTime,
        onchange: onChangeDateTime,
      ),
      CkTextField(
        label: 'Описание',
        onchange: onChangeDescription,
      ),
    ];
  }

  List<Widget> secondScreen() {
    return <Widget>[
      CkTextField(
        controller: clientNameController,
        label: 'Имя клиента',
        onchange: onChangeClientName,
      ),
      CkTextField(
        controller: clientContactController,
        label: 'Контакты клиента',
        onchange: onChangeClientContact,
      ),
      CkTextField(
        controller: priceController,
        label: 'Сумма',
        onchange: onChangePrice,
      ),
    ];
  }

  bool _firstScreen = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Text header = Text(
        _firstScreen ? 'Далее' : 'Готово',
        style: theme.textTheme.body1.copyWith(color: Colors.white)
    );
    List<Widget> childrens = _firstScreen ? firstScreen() : secondScreen();
    Function onPress = _firstScreen ? nextScreen : save;
    return Scaffold(
      appBar: AppBar(
        title: Text(_hasName && model != null ? model.orderName : 'Новый заказ'),
        actions: <Widget> [
          FlatButton(
            child: header,
            onPressed: onPress
          )
        ]
      ),
      body: Form(
        onWillPop: _onWillPop,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: childrens.map<Widget>((Widget child) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              height: 96.0,
              child: child
            );
          }).toList()
        )
      ),
    );
  }
}
