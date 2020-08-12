import 'package:flutter/material.dart';

class CornerSymbolWidget extends StatelessWidget {
  CornerSymbolWidget({@required this.symbol});
  String symbol;
  @override
  Widget build(BuildContext context) {
    return
      Row(
        children: [

          Image(image: AssetImage('assets/$symbol.png'),height: 20,width: 20,),
          SizedBox(width: 25,),
          Image(image: AssetImage('assets/$symbol.png'),height: 20,width: 20,),
        ],
      );

      //Image(image: AssetImage('assets/$symbol.png'),height: 20,width: 20,);
  }
}
