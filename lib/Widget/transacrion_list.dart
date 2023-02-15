import 'package:flutter/material.dart';
import './transaction_item.dart';
import 'package:flutterapp/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty?
      LayoutBuilder(builder: (context, constraints) {
        return   Column(
           children: [
            Text('No Transaction Added Yet',
            style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: constraints.maxHeight*0.1,
            
            ),
            Container(
              height: constraints.maxHeight*0.6,
            child: Image.asset('images/Chutiya.jpg',fit: BoxFit.cover,))
           ],
      );
      })
     :
       ListView.builder(
        itemBuilder: (ctx, index) {
          return TransactionItem(transactions: transactions[index], deleteTx: deleteTx);
        },
        itemCount: transactions.length,
      ),
    );
  }
}

