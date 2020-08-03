import 'package:flutter/material.dart';
import 'package:todolist/models/Transaction.dart';
import 'package:todolist/widgets/chart.dart';
import 'package:todolist/widgets/transaction_create.dart';
import 'package:todolist/widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App',
        home: MyHomePage(),
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)))));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: '1', title: 'todow1', amount: 9.99, date: new DateTime.now()),
    // Transaction(
    //     id: '2', title: 'tododt', amount: 69.0000, date: new DateTime.now()),
    // Transaction(
    //     id: '3', title: 'todo', amount: 69.99, date: new DateTime.now()),
    // Transaction(
    //     id: '4', title: 'todo2', amount: 69.99, date: new DateTime.now()),
    // Transaction(
    //     id: '5', title: 'todo2', amount: 69.99, date: new DateTime.now()),
    // Transaction(
    //     id: '6', title: 'todo3', amount: 69.99, date: new DateTime.now()),
    // Transaction(
    //     id: '7', title: 'todo4', amount: 69.99, date: new DateTime.now()),
    // Transaction(
    //     id: '7', title: 'todo5', amount: 69.99, date: new DateTime.now()),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addTransaction(String title, double amount, DateTime chosenDate) {
    var newTx = Transaction(
        amount: amount,
        title: title,
        id: DateTime.now().toString(),
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: TransactionCreate(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Flutter App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.3,
            child: Chart(_recentTransaction)),
        Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.7,
            child: TransactionList(_userTransactions, _deleteTransaction))
      ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
