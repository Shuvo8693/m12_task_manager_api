
import 'package:flutter/material.dart';

class CardSummary extends StatelessWidget {
  const CardSummary({
    super.key, required this.count, required this.title,
  });
 final String count,title; /// value ta ei helper class e nea ashar jonno request kora hocce
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:20,vertical: 8 ),
        child: Column(
          children: [
            Text(count,style: Theme.of(context).textTheme.titleLarge,),  ///value ta ekhane variable er moddome ana hoace
           Text(title)
          ],
        ),
      ),
    );
  }
}