import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate ;
  void submitData() {
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }
void _presentDatePicker(){
  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), 
  lastDate: DateTime.now()).then((pickedDate){
    if(pickedDate == null)  return;
    setState(() {
          _selectedDate = pickedDate;
    });
    print('...');
  });
}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top:10 ,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(child: Text(_selectedDate == null ? 'No Date Chosen!' : DateFormat.yMd().format(_selectedDate!).toString())),
                    FlatButton(onPressed: _presentDatePicker
                    ,textColor: Theme.of(context).primaryColor, child: Text('Choose Date'
                  ,  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),)
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Color.fromARGB(255, 206, 164, 218),
                child: Text('Add Transaction'),
                onPressed: submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
