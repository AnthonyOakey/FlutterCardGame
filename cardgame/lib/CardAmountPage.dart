import 'package:flutter/material.dart';
import 'CardWidget.dart';
import 'DecidingCardOrderWidget.dart';
import 'package:cardgame/DecidingCardAmount.dart';
import 'PopWidget.dart';
//https://proandroiddev.com/flutter-from-zero-to-comfortable-6b1d6b2d20e
//https://medium.com/@DakshHub/flutter-displaying-dynamic-contents-using-listview-builder-f2cedb1a19fb
class CardAmountPage extends StatefulWidget {
  CardAmountPage({@required this.Cards2,@required this.CardRefresh, @required this.CardAmount, @required this.DefaultCards});
  void Function() DefaultCards;
  void Function(int,int) CardAmount;
  void Function(int,int) CardRefresh;
  static const String id='CardAmountPageID';
  List <String> suits=['heart','diamond','spade','jack'];
  List <List<dynamic>>  Cards2;
  @override
  _CardAmountPageState createState() => _CardAmountPageState();
}

class _CardAmountPageState extends State<CardAmountPage> {
  List<CardDeciding> CardRows=[];
  List<Widget> MovingList=[];
  List <Widget> FinalWidgetList=[];
  void refesh2(int oldone,int newone) async {


    setState(() {
      var temp=CardRows[newone];
      var newlocation=temp.ReturnLocation();
      var oldlocation=CardRows[oldone].ReturnLocation();
      CardRows[newone]=CardRows[oldone];
      CardRows[oldone]=temp;
     CardRows[oldone].ReplaceLocation(oldlocation);
     CardRows[newone].ReplaceLocation(newlocation);

    });
    widget.CardRefresh(oldone,newone);
  }

  @override
  void initState (){
    for(int i = 0; i < widget.Cards2.length; i++){

      this.CardRows.add( CardDeciding(CardList: widget.Cards2[i],location:i,CardAmount:widget.CardAmount),);
      this.MovingList.add( DecidingOrder(oldindex: i,maxlength:widget.Cards2.length,refresh:this.refesh2,),);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [ Expanded(child:


      ListView.builder(itemCount:this.CardRows.length,itemBuilder: (context,i){
        return Row(children:[this.CardRows[i], this.MovingList[i]]);

      },)),

Row(children: [
    PopNav(text: 'Go Back'),
FlatButton(onPressed: (){
  setState(() {
    widget.DefaultCards();
  });

    }, child: Text('Default'))]),

      ])

    );
  }
}












