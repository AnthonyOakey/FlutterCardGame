import 'package:flutter/material.dart';
import 'CardWidget.dart';
import 'package:provider/provider.dart';
import 'DeckClass.dart';
import 'package:cardgame/PlayerHandWidget.dart';
import 'TexasHand.dart';
import 'TexasAIClass.dart';
import 'PlayerWalletClass.dart';
import 'package:async/async.dart';
class TexasGame extends StatefulWidget {
  TexasGame({@required this.deck,@required this.playeramount});
  Deck deck;
  int playeramount;
  static const String id='TexasGameID';
  @override
  _TexasGameState createState() => _TexasGameState();
}

class _TexasGameState extends State<TexasGame> {
  // Each AI own class
  //-1 fold 0 call 1 bet to place car sum 1 or less then place card1
  bool endTurn=false;
  bool PlayersTurn=true;
  List<int> PlayersActions=[0,0,0,0];
  //All have to have went sum should be 4
  List<int> HaveWent=[0,0,0,0];
  List<Text> AIText=[Text(''),Text(''),Text('')];
  TexasAI AI1=new TexasAI();
  TexasAI AI2=new TexasAI();
  TexasAI AI3=new TexasAI();
  List<int> LastBet=[0,0,0,0];
  int currentbet=0;
  int Pot=0;

  Text middleText=Text('');

  int DecideWinner(){
    print ('WINNERCALL');



    int bestplace=-1;
    int bestcombo=-1;
    String ComboText='';
    if (this.PlayersActions[0]!=-1) {
      bestplace=0;
      bestcombo = this.PlayerHand2.ReturnBestRankCombo();
      ComboText = this.PlayerHand2.ReturnComb();
    }
    if (this.AI1.CurrentHand.ReturnBestRankCombo()>bestcombo && this.PlayersActions[1]!=-1){
      bestplace=1;
      bestcombo=this.AI1.CurrentHand.ReturnBestRankCombo();
      ComboText=this.AI1.CurrentHand.ReturnComb();
    }
    if (this.AI2.CurrentHand.ReturnBestRankCombo()>bestcombo && this.PlayersActions[2]!=-1){
      bestplace=2;
      bestcombo=this.AI2.CurrentHand.ReturnBestRankCombo();
      ComboText=this.AI2.CurrentHand.ReturnComb();
    }
    if (this.AI3.CurrentHand.ReturnBestRankCombo()>bestcombo && this.PlayersActions[3]!=-1){
      bestplace=3;
      bestcombo=this.AI3.CurrentHand.ReturnBestRankCombo();
      ComboText=this.AI3.CurrentHand.ReturnComb();
    }
    print ('BEST');
    print (bestplace);
    print (this.Pot.toString());

      switch (bestplace){
        case 0:{
          setState(() {

          });


      }
      break;
        case 1:{
        setState(() {
          print ('A1 Payed '+this.Pot.toString());
          print ("A1 before "+this.AI1.Wallet.toString());

          this.AI1.AddMoney(this.Pot);
          print ("A1 After "+this.AI1.Wallet.toString());
          this.Pot=0;
        });

      } break;
        case 2:{
          setState(() {
            print ('A2 Payed '+this.Pot.toString());
            print ("A2 before "+this.AI2.Wallet.toString());

            this.AI2.AddMoney(this.Pot);
            print ("A2 After "+this.AI2.Wallet.toString());
            this.Pot=0;
          });

        } break;
        case 3:{
          setState(() {
            print ('A3 Payed '+this.Pot.toString());
            print ("A3 before "+this.AI3.Wallet.toString());

            this.AI3.AddMoney(this.Pot);
            print ("A3 After "+this.AI3.Wallet.toString());
            this.Pot=0;
          });

        } break;
      }

      this.middleText=Text('The Winner is Player $bestplace with $ComboText  Play Again?');

return bestplace;
  }




  bool GameOver=false;

  List<Cards> PlayersHand=[];
  int playertotal=0;
  Widget Hand=Text('');
  TexasHand PlayerHand2=TexasHand();

  List<Cards> DealerHand=[];
  TexasHand DealerHand2=TexasHand();

  Widget CurrentState=Text('');
  String MatchValue='';
  int betamount=0;



  int ShouldCardBeAdded() {
    int ok = 10;
    print('Hello');
    //check value of actions if 1 only and already went on all then place card
    List<int> aliveplayers = [];
    int count1 = 0;
    int wentcount = 0;
    for (int i = 0; i < this.PlayersActions.length; i++) {
      this.PlayersActions[i] > -1 ? aliveplayers.add(i) : true;
      this.PlayersActions[i] == 1 ? count1 = count1 + 1 : count1 = count1;
      this.HaveWent[i] == 1 ? wentcount = wentcount + 1 : wentcount = wentcount;
    }
    print("L");
    print(this.PlayersActions.toString());
    print(this.HaveWent.toString());
    print(count1.toString());
    print(wentcount.toString());
    print('ALIVE '+aliveplayers.length.toString());
    if (aliveplayers.length > 1) {
      if (count1 < 2 && wentcount == 4) {
        if (this.DealerHand.length < 5) {
          Cards newcard = widget.deck.Deal();
          setState(() {
            this.AddCardAllHands(newcard);
          });
        }
        else {
          setState(() {
            ok = this.DecideWinner();
            this.endTurn = true;
          });
        }
      }
      if (ok == 0) {
        return 0;
      }
    }
    else {
      setState(() {
        ok = this.DecideWinner();
        this.endTurn = true;
      });
      return 0;
    }
  }


  void AITurn(TexasAI AI, int place){
    Text text=Text("");
    if (AI.Wallet>0 && this.PlayersActions[place]!=-1) {
      int decision = AI.MakeDecision();
      this.PlayersActions[place] = decision;
      switch (decision) {
        case -1:
          {
            text = Text('Folded');
            this.PlayersActions[place] = -1;
          }
          break;
        case 0:
          {
            int minamount = this.currentbet - this.LastBet[place];
            if (minamount > AI.Wallet) {
              minamount = AI.Wallet;
            }
            this.LastBet[place] = minamount+this.LastBet[place];
            setState(() {
              this.Pot = this.Pot + minamount;
            });

            AI.AddMoney(-minamount);
            this.PlayersActions[place] = 0;


            text = Text('Called for $currentbet');
          }
          break;
        case 1:
          {
            int minamount = this.currentbet - this.LastBet[place];
            int betamount = AI.BetAmount(minamount);
            betamount>AI.Wallet?betamount=AI.Wallet:true;
            //AI.AddMoney(-betamount);
            setState(() {
              this.Pot = this.Pot + betamount;
            });
            this.LastBet[place] = this.currentbet + betamount;
            this.PlayersActions[place] = 1;
            this.currentbet = this.currentbet + betamount;
            text=Text('Bet for $betamount');
          }
      }
      this.HaveWent[place] = 1;

      setState(() {
        this.AIText[place-1] = text;
        this.betamount=this.currentbet-this.LastBet[0];
      });
    }
  }

  void AddCardAllHands(Cards Card){
    print ("ADDCARDS");
    this.AI1.AddCard(Card);
    this.AI2.AddCard(Card);
    this.AI3.AddCard(Card);

    setState(() {
      this.PlayerHand2.AddCard(Card);
      this.DealerHand2.AddCard(Card);
      this.DealerHand.add(Card);
      this.MatchValue=PlayerHand2.ReturnComb();


    });
  }


  void AddCard(){
    setState(() {
      Cards car=widget.deck.Deal();
      this.AddCardAllHands(car);
      this.MatchValue=PlayerHand2.ReturnComb();
    });

  }
  void FixAITEXT(){
    for (int i = 1; i < this.PlayersActions.length; i++){
      setState(() {
        this.PlayersActions[i]==-1?this.AIText[i-1]=Text('Folded'):this.AIText[i-1]=Text("");
      });

    }
  }
  void NewState(){
    setState(() {
      this.betamount=0;
      this.currentbet=0;
      this.Pot=0;
      this.endTurn=false;
      this.middleText=Text('');
      this.PlayerHand2.Clear();
      this.DealerHand2.Clear();
      this.DealerHand=[];
      this.PlayersHand=[];
      this.PlayersTurn=true;
      this.LastBet=[0,0,0,0];
      this.PlayersActions=[0,0,0,0];
      this.HaveWent=[0,0,0,0];
      this.AIText=[Text(''),Text(''),Text('')];
      if (this.AI1.Wallet<=0){
        this.PlayersActions[1]=-1;
        this.HaveWent[1]=1;
        this.AIText[0]=Text('Folded');
      }
      if (this.AI2.Wallet<=0){
        this.PlayersActions[2]=-1;
        this.HaveWent[2]=1;
        this.AIText[1]=Text('Folded');
      }
      if (this.AI3.Wallet<=0){
        this.PlayersActions[3]=-1;
        this.HaveWent[3]=1;
        this.AIText[2]=Text('Folded');
      }


      this.AddCard();
      Cards car=widget.deck.Deal();
      this.PlayerHand2.AddCard(car);
      this.MatchValue=PlayerHand2.ReturnComb();
      this.PlayersHand.add(car);

      car=widget.deck.Deal();
      this.PlayerHand2.AddCard(car);
      this.MatchValue=PlayerHand2.ReturnComb();
      this.PlayersHand.add(car);

       car=widget.deck.Deal();
       this.AI1.AddCard(car);
      car=widget.deck.Deal();
      this.AI1.AddCard(car);

      car=widget.deck.Deal();
      this.AI2.AddCard(car);
      car=widget.deck.Deal();
      this.AI2.AddCard(car);


      car=widget.deck.Deal();
      this.AI3.AddCard(car);
      car=widget.deck.Deal();
      this.AI3.AddCard(car);

    });



  }

  @override
  void initState() {
    setState(() {
      this.NewState();

    });

  }


int yo=6;
  @override
  Widget build(BuildContext context) {



    var puts= Provider.of<PlayerWallet>(context);
    return Scaffold(

      body: Center(child:Column(
        children: [
          SizedBox(height: 30,),
          Center(child:Row(children: [Center(child:Text('Player 1  ')),Center(child:Text(this.AI1.Wallet.toString()+'  ')),Center(child:this.AIText[0])],)),
          Center(child:Row(children: [Text('Player 2  '),Text(this.AI2.Wallet.toString()+'  '),this.AIText[1]],)),
          Center(child:Row(children: [Text('Player 3  '),Text(this.AI3.Wallet.toString()+'  '),this.AIText[2]],)),
          Expanded(child: PlayerHand(PlayerHands: this.DealerHand, total:'' )),
          Row(children: [
            PlayersTurn && !endTurn  ? IconButton(icon: Icon(Icons.add), onPressed: (){
              if (this.betamount<puts.inputs){

                setState(() {
                  this.betamount=this.betamount+1;
                });

              }

            }): SizedBox(width: 30,),PlayersTurn && !endTurn? Text(this.betamount.toString()): SizedBox(width: 20,),

            PlayersTurn && !endTurn  && puts.inputs>0? IconButton(icon: Icon(Icons.remove), onPressed: (){
              if (this.betamount>this.currentbet-this.LastBet[0]){
                setState(() {
                  this.betamount=this.betamount-1;
                });

              }
            }): SizedBox(width: 50,),


            Text('Currently Worth '+ puts.inputs.toString()),
              ],),!this.endTurn?Text('Current Bet '+this.currentbet.toString()+'  You Last Bet '+this.LastBet[0].toString()):SizedBox(height: 20,)
          ,
          Row(
            children: [
              PlayersTurn && !endTurn?FlatButton(onPressed: () async {

                if (this.endTurn==false){
                if (this.betamount>puts.inputs){
                  this.betamount=puts.inputs;
                }

                setState(() {
                  puts.ChangeAmount(-betamount);
                  this.Pot=this.Pot+betamount;
                  this.PlayersTurn=false;
                });
                if (this.betamount+this.LastBet[0]>this.currentbet){
                  this.currentbet=this.betamount+this.LastBet[0];
                }
                this.LastBet[0]=this.betamount+this.LastBet[0];
                await Future.delayed(const Duration(milliseconds: 500));
                this.AITurn(this.AI1, 1);
                await Future.delayed(const Duration(milliseconds: 500));
                this.AITurn(this.AI2, 2);
                await Future.delayed(const Duration(milliseconds: 500));
                this.AITurn(this.AI3, 3);
                await Future.delayed(const Duration(milliseconds: 500));

                setState(() {
                  this.HaveWent[0]=1;
                  this.PlayersActions[0]=1;
                  yo=this.ShouldCardBeAdded();
                  if (yo==0){
                    setState(() {
                      puts.ChangeAmount(this.Pot);
                      this.Pot=0;
                      this.FixAITEXT();
                    });
                  }
                  this.PlayersTurn=true;
                });

              }

              }
                , child: Text('Bet')):SizedBox(width: 25,),
              PlayersTurn && !endTurn?FlatButton(onPressed: () async {
                if (this.endTurn==false){
                int callamount=this.currentbet-this.LastBet[0];
                if (callamount>puts.inputs){
                  callamount=puts.inputs;
                }

                setState(() {
                  puts.ChangeAmount(-callamount);
                  this.Pot=this.Pot+1;
                  this.FixAITEXT();
                });
                this.LastBet[0]=this.currentbet;
                await Future.delayed(const Duration(milliseconds: 500));

                this.AITurn(this.AI1, 1);
                await Future.delayed(const Duration(milliseconds: 500));
                this.AITurn(this.AI2, 2);
                await Future.delayed(const Duration(milliseconds: 500));
                this.AITurn(this.AI3, 3);
                await Future.delayed(const Duration(milliseconds: 500));

                setState(() {
                  this.HaveWent[0]=1;
                  this.PlayersActions[0]=0;
                  yo=this.ShouldCardBeAdded();
                  if (yo==0){
                    setState(() {
                      puts.ChangeAmount(this.Pot);

                    });
                  }

                  this.PlayersTurn=true;
                });
              }
}, child: Text('Call')):SizedBox(width: 25,),
              PlayersTurn && !endTurn?FlatButton(onPressed: () async {
                setState(() {
                  this.FixAITEXT();
                  this.PlayersTurn=true;
                  this.PlayersActions[0]=-1;
                  this.HaveWent[0]=1;
                });
                print ("H");
                print (this.endTurn.toString());
                while (!this.endTurn){
                  setState(() {
                    this.FixAITEXT();
                  });
                  print ('Hey');
                  print (this.endTurn.toString());
                  await Future.delayed(const Duration(milliseconds: 500));
                  this.AITurn(this.AI1, 1);
                  await Future.delayed(const Duration(milliseconds: 500));
                  this.AITurn(this.AI2, 2);
                  await Future.delayed(const Duration(milliseconds: 500));
                  this.AITurn(this.AI3, 3);
                  await Future.delayed(const Duration(milliseconds: 500));
                  this.ShouldCardBeAdded();
                }
                setState(() {
                  this.PlayersTurn=true;
                  this.endTurn=true;

                });

              }, child: Text('Fold')):SizedBox(width: 25,),
              SizedBox(height: 40,),


              ],
          ),
          this.endTurn?FlatButton(onPressed: (){
            setState(() {
              if  (puts.inputs>0) {
                this.NewState();
                this.endTurn = false;
              }
            });
          }, child: middleText):SizedBox(width: 25,),
          Expanded(child: PlayerHand(PlayerHands: this.PlayersHand, total: this.MatchValue)),


FlatButton(onPressed: (){
  Navigator.pop(context);
}, child: Text("Return")),
        ],
      )),

    );
  }
}
