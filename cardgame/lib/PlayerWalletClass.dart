import 'package:flutter/material.dart';

class PlayerWallet extends ChangeNotifier{
  int _ins=-1;
  int get inputs{
    return _ins;
  }
  set inputs (int amount){
    _ins=_ins;

    notifyListeners();
  }



  void ChangeAmount(int text){
    _ins=_ins+text;

    inputs=text;
    //notifyListeners();
  }
}