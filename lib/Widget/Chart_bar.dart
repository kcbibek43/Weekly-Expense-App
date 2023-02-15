import 'package:flutter/material.dart';
class ChartBar extends StatelessWidget {
   final String label;
   final double spendingAmount;
   final double spendingPctofTotal;
ChartBar(this.label,this.spendingAmount,this.spendingPctofTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
          return Column(
      children: [
      Container(
        height: constraints.maxHeight*0.15,
        child: FittedBox(
          child:   Text('\$${spendingAmount.toStringAsFixed(0)}'),
        ),
      ),
      SizedBox(height: constraints.maxHeight*0.05,),
      Container(
        height: constraints.maxHeight*0.6,
        width: 10,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1.0),
            color: Color.fromARGB(220, 239, 239, 234),
            borderRadius: BorderRadius.circular(10),
            ),
          ),
        FractionallySizedBox(
          heightFactor: spendingPctofTotal,
        child: Container(decoration: BoxDecoration(color: Colors.amberAccent),),),
         ],
        )
      ),
      SizedBox(
     height: constraints.maxHeight*0.05,
      ),
      Container(height: constraints.maxHeight*0.15, child: FittedBox(
        child: 
          Text(label),
      )),
      ]
          );
    }),
    );
  }
}