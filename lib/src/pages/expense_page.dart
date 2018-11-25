import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/src/auth_provider.dart';
import 'package:mobile/src/models/cake_card.dart';
import 'package:mobile/src/models/expense_card.dart';
import 'package:mobile/src/models/expense_model.dart';
import 'package:mobile/src/pages/add_expense_dialog.dart';


class ExpensePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ExpensePageState();

}

class _ExpensePageState extends State<ExpensePage> {
  List<ExpenseModel> expenses = new List();
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

  void addExpense() {
    Navigator.push(context, MaterialPageRoute<DismissDialogAction>(
      builder: (BuildContext context) => AddExpenseDialog(),
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('expenses').where('userId', isEqualTo: userId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, int index) {
                ExpenseModel expenseModel = ExpenseModel
                    .fromDoc(snapshot.data.documents[index]);
                // debugger();
                return ExpenseCard(
                  name: expenseModel.name,
                  type: expenseModel.type,
                  value: expenseModel.value,
                );
              }
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: addExpense,
        tooltip: 'Add new expense',
        child: new Icon(Icons.add),
      ),
    );
  }

}