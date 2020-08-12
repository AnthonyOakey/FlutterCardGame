import 'CardWidget.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class Deck{
  List<Cards> LiveCard=[];
  List<Cards> DeadCard=[];

  void AddCards(List<Cards> Cards2){
    for (Cards card in Cards2){
      this.LiveCard.add(card);
    }
  }
  Cards Deal(){
    if (this.LiveCard.length==0){
      this.AddCards(this.DeadCard);
    }
    Cards dealedcard=this.LiveCard[0];
    this.DeadCard.add(dealedcard);
    this.LiveCard.remove(dealedcard);
    return dealedcard;

  }

  void Shuffle() {
    var random = new Random();
    for (var i = this.LiveCard.length - 1; i > 0; i--) {

      var n = random.nextInt(i + 1);

      var temp = this.LiveCard[i];
      this.LiveCard[i] = this.LiveCard[n];
      this.LiveCard[n] = temp;
    }

  }



}