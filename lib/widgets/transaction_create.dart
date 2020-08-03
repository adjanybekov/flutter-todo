import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCreate extends StatefulWidget {
  final Function createTransaction;

  TransactionCreate(this.createTransaction);

  @override
  _TransactionCreateState createState() => _TransactionCreateState();
}

class _TransactionCreateState extends State<TransactionCreate> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _pickedDate;

  @override
  Widget build(BuildContext context) {
    void _submitData() {
      if (_pickedDate == null ||
          amountController.text.isEmpty ||
          titleController.text.isEmpty) return;
      widget.createTransaction(titleController.text,
          double.parse(amountController.text), _pickedDate);
      Navigator.of(context).pop();
    }

    void _presentDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime.now())
          .then((value) {
        if (value == null) return;
        setState(() {
          _pickedDate = value;
        });
      });
    }

    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_pickedDate == null
                        ? 'No Date chosen!'
                        : 'Date: ${DateFormat.yMd().format(_pickedDate)}'),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}
