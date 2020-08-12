import 'package:flutter/material.dart';

class CardDeciding extends StatefulWidget {

  CardDeciding({@required this.CardList,@required this.location, @required this.CardAmount});
  int location;
  void Function(int,int) CardAmount;
  void ReplaceLocation(int newlocation){
    location=newlocation;
  }
  int ReturnLocation(){
    return this.location;
  }
  List GetCardList(){
    return this.CardList;
  }
  List<dynamic> CardList;
  @override
  _CardDecidingState createState() => _CardDecidingState();
}

class _CardDecidingState extends State<CardDeciding> {

  @override
  Widget build(BuildContext context) {
    return Row(
        children:[
          Image(image:AssetImage('assets/'+widget.CardList[0].toString()+'.png'),width: 50,height: 50,),
          FlatButton(onPressed: (){
            setState((){
              if (widget.CardList[1]>0) {

                widget.CardList[1] =
                    widget.CardList[1] - 1;
                widget.CardAmount(widget.location,-1);
              }
            });

          }, child: Icon(Icons.remove)),

          Container(child:Text(widget.CardList[1].toString())),
          FlatButton(onPressed: (){
            setState((){
              if (widget.CardList[1]<9) {
                widget.CardList[1] =
                    widget.CardList[1] + 1;
                widget.CardAmount(widget.location,1);
              }
            });

          }, child: Icon(Icons.add)),

        ]
    );
  }
}