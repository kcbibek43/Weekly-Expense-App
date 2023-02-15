import 'package:flutter/material.dart';
import 'package:flutterapp/transaction.dart';
import 'package:intl/intl.dart';
import './Chart_bar.dart';
class Chart extends StatelessWidget {

    final List<Transaction> rescentTransaction;
     Chart(this.rescentTransaction);
List<Map<String,Object>> get groupedTransactionValues{
  return List.generate(7, (index){
    final weekDay = DateTime.now().subtract(Duration(days: index),);
    double totalSum = 0.0;
    for(var i = 0;i<rescentTransaction.length;i++){
      if(rescentTransaction[i].date.day == weekDay.day &&
       rescentTransaction[i].date.month == weekDay.month &&
       rescentTransaction[i].date.month == weekDay.month){
       totalSum += rescentTransaction[i].amount;
      }
    }
    return {'Day': DateFormat.E().format(weekDay).substring(0,1),
    'amount': totalSum};

  }
  ).reversed.toList();
}
double get totalSpending{
  return groupedTransactionValues.fold(0.0,(sum , item){
    return sum + (item['amount'] as double);
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(data['Day'].toString(), (data['amount'] as double),
                 totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}