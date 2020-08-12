import 'package:flutter/material.dart';
import 'CardWidget.dart';
import 'TexasHand.dart';
import 'dart:math';
import 'dart:math';

class TexasAI{
  TexasHand CurrentHand=TexasHand();
  int Wallet=100;


  void AddCard(Cards Card){
    this.CurrentHand.AddCard(Card);
  }

  int CurrentValue(){
    return this.CurrentHand.ReturnBestRankCombo();
  }

  void AddMoney(int amount){
    this.Wallet=this.Wallet+amount;
  }

  int MakeDecision(){
    int combo=this.CurrentHand.ReturnBestRankCombo();
    int betcutoff=(combo+1)*10;
    double callcutoff=((100-betcutoff)/3)*2+betcutoff;
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    if (randomNumber<betcutoff){
       if (this.Wallet>5){
         return 1;
       }
      else{
        return 0;
       }
    }
    else if (randomNumber>betcutoff && randomNumber<callcutoff){
      return 0;
    }
    else return -1;



  }

  int BetAmount(int minamount){
    if (this.Wallet>0) {
      int combo = this.CurrentHand.ReturnBestRankCombo();
      double combo2 = (combo + 1) / 10;
      int betamount = (this.Wallet * combo2).toInt();
      betamount < minamount
          ?
      minamount > this.Wallet ? betamount = this.Wallet : betamount = minamount
          : betamount = betamount;
      this.AddMoney(-betamount);
      return betamount;
    }
    else{
      return 0;
    }
  }

  void Clear(){
    this.CurrentHand.Clear();
    this.CurrentHand=TexasHand();
  }





}