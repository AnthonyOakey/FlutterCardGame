import 'package:flutter/material.dart';
import 'CardWidget.dart';
import 'package:cardgame/DeckClass.dart';
import 'BlackJackHand.dart';
import 'PlayerHandWidget.dart';
import 'package:provider/provider.dart';
import 'package:cardgame/PlayerWalletClass.dart';
class BlackJackGame extends StatefulWidget {
  static const String id='BlackJackGame';
  BlackJackGame({@required this.deck, @required this.PlayerMoney});
  int PlayerMoney;
  Deck deck;
  @override
  _BlackJackGameState createState() => _BlackJackGameState();
}

class _BlackJackGameState extends State<BlackJackGame> {
  bool GameOver=false;
  int pot=0;
  List<Cards> PlayersHand=[];
  int playertotal=0;
  Widget Hand=Text('');
  BlackJackHand PlayerHand2=BlackJackHand();
  List<Cards> DealersHand=[];
  BlackJackHand DealersHand2=BlackJackHand();
  Widget CurrentState=Text('');

  void CleanState(){
    this.PlayerHand2.Restart();
    this.playertotal=0;
    this.PlayersHand=[];
    this.Hand=Text('');
    this.DealersHand2.Restart();
    this.DealersHand=[];
    var newcar=widget.deck.Deal();
    this.DealersHand2.AddValue(newcar.ReturnWorth());
    this.DealersHand.add(newcar);
  }
  int betamount=0;

  @override
  void initState (){
this.CleanState();
  }

  @override
  Widget build(BuildContext context) {
    var puts= Provider.of<PlayerWallet>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: PlayerHand(PlayerHands: this.DealersHand, total: this.DealersHand2.CheckValue())),
          this.CurrentState,
          Row(children: [
            PlayersHand.length<=1 ? IconButton(icon: Icon(Icons.add), onPressed: (){
              if (this.betamount<widget.PlayerMoney){
                setState(() {
                  this.betamount=this.betamount+1;
                });

              }
            }): SizedBox(width: 30,),PlayersHand.length<=1 ? Text(this.betamount.toString()): SizedBox(width: 50,),

            PlayersHand.length<=1 ? IconButton(icon: Icon(Icons.remove), onPressed: (){
              if (this.betamount>0){
                setState(() {
                  this.betamount=this.betamount-1;
                });

              }
            }): SizedBox(width: 30,),

            PlayersHand.length<=1 ? FlatButton(onPressed: (){
              puts.ChangeAmount(-this.betamount);
              setState(() {
                this.pot=this.pot+this.betamount;

              });


            }, child: Text('Bet')):SizedBox(width: 35,),

             Text('Currently Worth'),
            Text(puts.inputs.toString())
          ],),
           pot>0? Text('Pot Is $pot'):SizedBox(height: 25,) ,
          Row(children:[this.GameOver==false? FlatButton(onPressed: (){
            setState(() {
              var car=widget.deck.Deal();
              bool bust=PlayerHand2.AddValue(car.numberworth);
              print (bust);
              print (PlayerHand2.CheckValue());
              var valq=PlayerHand2.CheckValue();
              if (bust){
                setState(() {
                  this.GameOver=true;
                });
                PlayerHand2.Restart();


                this.Hand=FlatButton(onPressed: (){
                  setState(() {
                    this.CleanState();
                  });

                }, child: Text('Busted With A Value of $valq Try Again'));

              }

              PlayersHand.add(car);
              for (Cards card in PlayersHand){
                setState(() {
                  this.playertotal=playertotal+card.ReturnWorth();
                });
              }


            });
    }, child: Text('Hit Me')):SizedBox(width: 50,),
            this.GameOver==false? FlatButton(onPressed: (){
            setState(() {
              this.GameOver=true;
              var car=widget.deck.Deal();
              this.DealersHand.add(car);
              bool bust = this.DealersHand2.AddValue(car.ReturnWorth());
              bool bust2=this.DealersHand2.CheckValue()>=17;
              while (bust==false && bust2==false){

    car=widget.deck.Deal();
    this.DealersHand.add(car);
     bust = this.DealersHand2.AddValue(car.ReturnWorth());
     bust2=this.DealersHand2.CheckValue()>=17;

    }
    var Final=this.PlayerHand2.GameComplete(this.DealersHand2.CheckValue());
             String textreset='';
              if (Final=='L' && bust==false){
                this.pot=0;
                textreset='You Loose Play Again?';


              }
              else if (Final=='T'){
                textreset='You Tie Play Again';
                puts.ChangeAmount(this.pot);
                this.pot=0;

    }
              else if (Final=='W' || bust==true){
                textreset='You Win Play Again';
                puts.ChangeAmount(this.pot*2);
                this.pot=0;

    }
              this.CurrentState=FlatButton(onPressed: (){
                setState(() {
                  this.GameOver=false;
                  this.CleanState();
                  this.CurrentState=Text('');
                });

              }, child:Text(textreset));
            });

          }, child: Text('Call')):SizedBox(width: 50,),

          ]),

Expanded(child: PlayerHand(PlayerHands: this.PlayersHand,total: PlayerHand2.CheckValue(),),),
          Hand,
FlatButton(onPressed: (){
  Navigator.pop(context);
}, child: Text('Return')),

        ],
      ),

    );
  }
}







