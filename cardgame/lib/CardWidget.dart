import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CornerSymbolWidget.dart';

class Cards extends StatelessWidget {
  Cards({@required this.centersymbol,@required this.outersymbol,@required this.numberworth,@required this.rankworth});
  String centersymbol;
  String outersymbol;
  int numberworth;
  int rankworth;
  String ReturnCenter(){
    return this.centersymbol;
  }
  String ReturnOuter(){
    return this.outersymbol;
  }

  int ReturnWorth(){
    return this.numberworth;

  }
  int ReturnRank(){
    return this.rankworth;

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: 75,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black
        )
      ),
      child: Column(
        children: [
CornerSymbolWidget(symbol: outersymbol),
          SizedBox(height: 20,),
          Center(child:Image(image: AssetImage('assets/$centersymbol.png'),height: 50,width: 50,)),
          SizedBox(height: 20,),
      CornerSymbolWidget(symbol: outersymbol),

        ],
      ),
    );
  }
}


