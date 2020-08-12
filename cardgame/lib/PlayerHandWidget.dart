import 'package:flutter/material.dart';
import 'CardWidget.dart';

class PlayerHand extends StatelessWidget {

  PlayerHand({@required this.PlayerHands,@required this.total});
  List<Cards> PlayerHands;
  var total;

  @override
  Widget build(BuildContext context) {

    return Column(children: [
      Expanded(child: ListView.builder(scrollDirection: Axis.horizontal,
          itemCount: this.PlayerHands.length,
          itemBuilder: (context, i) {

            return this.PlayerHands[i];
          }))
      ,Text('Worth $total')

    ]
    );
  }
}