import 'package:flutter/material.dart';
import 'package:flutterapp/transaction.dart';
import 'package:intl/intl.dart';
import './transacrion_list.dart';
class TransactionItem extends StatelessWidget {
  const TransactionItem({
    required this.transactions,
    required this.deleteTx,
  });

  final Transaction transactions;
  final Function deleteTx;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(7),
            child: FittedBox(
              child: Text('\$${transactions.amount}'),
            ),
          ),
        ),
        title: Text(transactions.title,style: Theme.of(context).textTheme.headline6,),
        subtitle: Text(DateFormat.yMMMd().format( transactions.date)),
        trailing: MediaQuery.of(context).size.width > 400 ?
      FlatButton.icon(
         icon: Icon(Icons.delete),
         label: Text('Delete'),
        textColor: Theme.of(context).errorColor,
        onPressed: (){
          return deleteTx(transactions.id);
        },)
        :
        IconButton(icon: Icon(Icons.delete),
        color: Theme.of(context).errorColor,
        onPressed: (){
          return deleteTx(transactions.id);
        },),
      ),
    );
  }
}
