class BlackJackHand{
  bool Bust=false;
  int total=0;

  bool AddValue(int value){
    this.total=this.total+value;
    if (this.total>21){
      this.Bust=true;
    }
    return this.Bust;


  }
  int CheckValue(){
    return this.total;
  }
  void Restart(){
    this.total=0;
    this.Bust=false;
  }

  String GameComplete(int value){
    if (value==this.total){
      return "T";
    }
    else if (value>this.total){
      return "L";
    }
    else{
      return 'W';
    }
  }

}