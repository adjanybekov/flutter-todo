import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;
  TransactionList(this._userTransactions, this._deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: _userTransactions.length == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'No trensactions',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                  height: 200,
                ),
              ],
            )
          : ListView.builder(
              itemCount: _userTransactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                            child:
                                Text('\$${_userTransactions[index].amount}')),
                        // Text('\$${tx.amount}')),
                      ),
                    ),
                    title: Text(
                      _userTransactions[index].title,
                      // tx.title,
                      style: Theme.of(ctx).textTheme.title,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        // .format(tx.date)),
                        .format(_userTransactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(ctx).errorColor,
                      onPressed: () {
                        // return _deleteTransaction(tx.id);
                        return _deleteTransaction(_userTransactions[index].id);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
