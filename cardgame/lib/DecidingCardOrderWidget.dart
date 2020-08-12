import 'package:flutter/material.dart';

class DecidingOrder extends StatelessWidget {
  DecidingOrder({ @required this.oldindex,@required this.maxlength, @required this.refresh});
  void Function(int,int) refresh;
  int oldindex;
  int maxlength;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(icon: Icon(Icons.keyboard_arrow_up), onPressed: (){
        if (oldindex!=0) {
          refresh(this.oldindex, this.oldindex-1);
        }

      }),
      IconButton(icon: Icon(Icons.keyboard_arrow_down), onPressed: (){
        if (oldindex!=this.maxlength-1) {
          refresh(this.oldindex, this.oldindex+1);
        }

      })
    ],);
  }
}