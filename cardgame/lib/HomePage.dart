import 'package:cardgame/TexasGame.dart';
import 'package:cardgame/extras.dart';
import 'package:flutter/material.dart';
import 'CardWidget.dart';
import 'CardAmountPage.dart';
import 'DeckClass.dart';
import 'BlackJackGame.dart';
import 'package:provider/provider.dart';
import 'PlayerWalletClass.dart';

//https://medium.com/flutter-community/building-a-chat-app-with-flutter-and-firebase-from-scratch-9eaa7f41782e
//https://flutternerd.com/build-a-fully-functioning-flutter-chat-app-with-firebase-part-1-4/
class HomePage extends StatefulWidget {
  static const String id='HomePageID';

  List <List<dynamic>>  Cards3=[
    ['King',4,13,10],
    ['Queen',4,12,10],
    ['Jack',4,11,10],
    ['10',4,10,10],
    ['9',4,9,9],
    ['8',4,8,8],
    ['7',4,7,7],
    ['6',4,6,6],
    ['5',4,5,5],
    ['4',4,4,4],
    ['3',4,3,3],
    ['2',4,2,2],
  ];

  List <List<dynamic>>  Cards2=[
    ['King',4,13,10],
    ['Queen',4,12,10],
    ['Jack',4,11,10],
    ['10',4,10,10],
    ['9',4,9,9],
    ['8',4,8,8],
    ['7',4,7,7],
    ['6',4,6,6],
    ['5',4,5,5],
    ['4',4,4,4],
    ['3',4,3,3],
    ['2',4,2,2],
  ];
  List <List<dynamic>>  DefaultCards3=[
    ['King',4,13,10],
    ['Queen',4,12,10],
    ['Jack',4,11,10],
    ['10',4,10,10],
    ['9',4,9,9],
    ['8',4,8,8],
    ['7',4,7,7],
    ['6',4,6,6],
    ['5',4,5,5],
    ['4',4,4,4],
    ['3',4,3,3],
    ['2',4,2,2],
  ];


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {




  void DefaultCards(){
    setState(() {
      widget.Cards3=widget.DefaultCards3;
      widget.Cards2=widget.DefaultCards3;
      Navigator.pop(context);
    });
  }

  //int PlayerWorth=100;

  void UpdateMoney(int amount){
    setState(() {
      var puts= Provider.of<PlayerWallet>(context);
      puts.ChangeAmount(amount);
    });

  }

  void CardAmounts(int place, int amount){
    widget.Cards2[place][1]=widget.Cards2[place][1]+amount;
  }

  void CardsRefresh(int oldint, int newint){
      String temp0 = widget.Cards2[oldint][0];
      int temp1 = widget.Cards2[oldint][1];
      widget.Cards2[oldint][0] = widget.Cards2[newint][0];
      widget.Cards2[oldint][1] = widget.Cards2[newint][1];
      widget.Cards2[newint][0] = temp0;
      widget.Cards2[newint][1] = temp1;

  }
  List <String> suits=['heart','diamond','spade','club'];
  Deck NewDeck=Deck();
  List<Cards> CardsList=[];
  @override
  Widget build(BuildContext context) {
    var puts= Provider.of<PlayerWallet>(context);
    if (puts.inputs==-1){
    puts.ChangeAmount(101);}
    return Scaffold(

        body: Column( children: [
          SizedBox(height: 50,),
          Center(child: Text('Current Player Worth'),),
        Center(child:Text(puts.inputs.toString())),
        Center(child:Cards(centersymbol: '10', outersymbol: 'heart', numberworth: 11, rankworth: 11)),
          FlatButton(onPressed: (){
            print (widget.Cards2);
            Navigator.push(context,MaterialPageRoute(builder: (context)=>CardAmountPage(Cards2: widget.Cards3, CardRefresh: this.CardsRefresh,CardAmount: this.CardAmounts,DefaultCards: this.DefaultCards,)));
          }, child: Text('Change Cards')),
          FlatButton(onPressed: (){
            NewDeck=Deck();
            for (var card in widget.Cards2){
              for(int i = 0; i < card[1]; i++) {
                NewDeck.AddCards([Cards(centersymbol: card[0], outersymbol: suits[i%suits.length], numberworth: card[3], rankworth: card[2])]);

              }
            }
            NewDeck.Shuffle();
            Navigator.push(context,MaterialPageRoute(builder: (context)=>BlackJackGame(deck: this.NewDeck,PlayerMoney: puts.inputs,)));
          }, child: Text('Game 21')),


          FlatButton(onPressed: (){
            NewDeck=Deck();
            for (var card in widget.Cards2){
              for(int i = 0; i < card[1]; i++) {
                NewDeck.AddCards([Cards(centersymbol: card[0], outersymbol: suits[i%suits.length], numberworth: card[3], rankworth: card[2])]);

              }
            }
            NewDeck.Shuffle();
            Navigator.push(context,MaterialPageRoute(builder: (context)=>TexasGame(deck: this.NewDeck,playeramount: puts.inputs,)));
          }, child: Text('Texas')),

        ],)

    );
  }
}





