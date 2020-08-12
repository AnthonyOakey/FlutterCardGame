import 'package:flutter/material.dart';

class PopNav extends StatelessWidget {
  PopNav({@required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return  FlatButton(onPressed: (){
      Navigator.pop(context);
    }, child: Text('$text'));
  }
}
