import 'CardWidget.dart';
import 'package:flutter/material.dart';
class TexasHand{
   Map Rankings={
     0:'High Card',
     1:'1 Pair',//x
     2: '2 Pair',//x
     3: '3 Of A Kind',//x
     4: 'Straight',
     5: 'Flush',//x
     6: 'Full House',//x
     7: '4 of a Kind',//x
     8: 'Straight Flush',
     9: 'Royal Flush',

   };

  Map symbolMap=Map();
  Map rankMap=Map();
  List<String>possiblecenter=[];
  List<String>possiblecorner=[];
  List<int>possiblerank=[];
  List<int>possibleworth=[];
  int bestrankcard=0;
  int bestrankcombo=0;


  int ReturnBestRankCombo(){
    return this.bestrankcombo;

  }
   int ReturnBestRankCard(){
     return this.bestrankcard;

   }
   String ReturnComb(){
    return this.Rankings[this.bestrankcombo];
   }

  void AddCard(Cards Card){
    Card.ReturnRank()>this.bestrankcard?this.bestrankcard=Card.ReturnRank():true;
    this.possiblecenter.add(Card.ReturnCenter());
    this.possiblecorner.add(Card.ReturnOuter());
    this.possiblerank.add(Card.ReturnRank());
    this.possibleworth.add(Card.ReturnWorth());

      if(!this.rankMap.containsKey(Card.ReturnRank())) {
        this.rankMap[Card.ReturnRank()] = 1;
      } else {
        this.rankMap[Card.ReturnRank()] +=1;
      }
    if(!this.symbolMap.containsKey(Card.ReturnOuter())) {
      this.symbolMap[Card.ReturnOuter()] = 1;
    } else {
      this.symbolMap[Card.ReturnOuter()] +=1;
    }
    CheckStatus();
    }



    void CheckStatus(){
    print ('Check');
    CheckForPairs();
    CheckFlush();
    List<int> Straights=CheckStraight();
    CheckStraightFlush(Straights);



    }




  void CheckForPairs(){
    int max=0;
    for (var key in this.rankMap.keys){
      this.rankMap[key]==2 && max==2? this.bestrankcombo<2?this.bestrankcombo=2:true:true;
      this.rankMap[key]==3 && max==3? this.bestrankcombo<6?this.bestrankcombo=6:true:true;
      this.rankMap[key]==3 || max==3? this.rankMap[key]==2||max==2?this.bestrankcombo<6?this.bestrankcombo=6:true:true:true;
      this.rankMap[key]>max? max=this.rankMap[key]: max==2 && this.rankMap[key]==2 &&  this.bestrankcombo<2? this.bestrankcard=2:max=max;
    }
    switch(max){
      case 2: {this.bestrankcombo<1?this.bestrankcombo=1:true;} break;
      case 3: {this.bestrankcombo<3?this.bestrankcombo=3:true;} break;
      case 4: {this.bestrankcombo<7?this.bestrankcombo=7:true;} break;

    }

  }

  void CheckFlush(){
    int max=0;
    for (var key in this.symbolMap.keys){

      this.symbolMap[key]>max? max=this.symbolMap[key]:max=max;

    }
    max==5 && this.bestrankcombo<5?this.bestrankcombo=5:true;



  }

  List<int> CheckStraight(){
    List<int> checkchards=possiblerank;
    checkchards.sort();
    int lengthofrun=0;
    List<int> seqvalues=[];
    for(int i = 0; i < checkchards.length-1; i++){
      checkchards[i]+1==checkchards[i+1]? i+1==checkchards.length-1? seqvalues.addAll([checkchards[i],checkchards[i+1]]): seqvalues.add(checkchards[i]):
          seqvalues.length<5?seqvalues=[]:seqvalues=seqvalues;

    }
    seqvalues.length>4&&this.bestrankcombo<4? this.bestrankcombo=4:true;
    return seqvalues;





  }

  void CheckStraightFlush(List<int> LookFor){
    Map Symbols=Map();
    bool Royal=false;
    LookFor.contains(13)?Royal=true:Royal=false;
    for(int i = 0; i < this.possiblerank.length-1; i++){
      if (LookFor.contains(this.possiblerank[i])){
        if(!Symbols.containsKey(this.possiblecorner[i])) {
          Symbols[this.possiblecorner[i]] = 1;
        } else {
          Symbols[this.possiblecorner[i]] +=1;
        }
      }

    }
    int max=0;
    for (var key in Symbols.keys){

      Symbols[key]>max? max=Symbols[key]:max=max;

    }
    max>4?Royal==true?this.bestrankcombo=9:this.bestrankcombo=8:this.bestrankcombo=this.bestrankcombo;


  }

  void Clear(){
     this.symbolMap=Map();
     this.rankMap=Map();
     this.possiblecenter=[];
     this.possiblecorner=[];
     this.possiblerank=[];
     this.possibleworth=[];
     this.bestrankcard=0;
     this.bestrankcombo=0;

  }

  }





