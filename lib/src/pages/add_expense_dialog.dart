import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/src/auth_provider.dart';
import 'package:mobile/src/models/expense_model.dart';
import 'package:mobile/src/widgets/ck_date_column.dart';
import 'package:mobile/src/widgets/ck_drop_down.dart';
import 'package:mobile/src/widgets/ck_text_field.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class AddExpenseDialog extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _AddExpenseDialogState();

}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  CollectionReference get expenses => Firestore.instance.collection('expenses');
  ExpenseModel model = new ExpenseModel();
  bool _saveNeeded = false;
  bool _hasValue = false;
  bool _hasName = false;
  String _userId;

  final List<String> _types = <String>['Продукты', 'Фото-печать', 'Такси', 'Прочие'];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then((id) {
      _userId = id;
    });
  }

  Future<bool> _onWillPop() async {
    _saveNeeded = _hasValue || _hasName || _saveNeeded;
    if (!_saveNeeded)
      return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
              'Discard new expense?',
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

  save() async {
    await _addExpense();
    Navigator.pop(context, DismissDialogAction.save);
  }

  Future<void> _addExpense() async {
    model.userId = _userId;
    await expenses.add(model.toJson());
  }

  onChangeName(String value) {
    setState(() {
      _hasName = value.isNotEmpty;
      if (_hasName) {
        model.name = value;
      }
    });
  }

  onChangeType(String value) {
    setState(() {
      model.type = value;
    });
  }

  onChangeValue(String value) {
    setState(() {
      _hasValue = value.isNotEmpty;
      if (_hasValue) {
        model.value = double.parse(value);
      }
    });
  }

  onChangeDate(DateTime value) {
    setState(() {
      model.date = value;
    });
  }

  List<Widget> buildContent() {
    ThemeData theme = Theme.of(context);
    return <Widget>[
      CkTextField(
        label: 'Название расхода',
        onchange: onChangeName,
      ),
      CkDropDown(
        title: 'Тип',
        selected: model.type,
        items: _types,
        onchange: onChangeType,
      ),
      CkTextField(
        label: 'Сумма',
        onchange: onChangeValue,
      ),
      DateTimeColumn(
        style: theme.textTheme.caption,
        dateTime: model.date,
        onchange: onChangeDate,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('Добавить расход'),
          actions: <Widget> [
            FlatButton(
                child: Text('Готово', style: theme.textTheme.body1.copyWith(color: Colors.white)),
                onPressed: save
            )
          ]
      ),
      body: Form(
        onWillPop: _onWillPop,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: buildContent().map<Widget>((Widget child) {
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