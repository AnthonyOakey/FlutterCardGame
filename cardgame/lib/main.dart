import 'package:flutter/material.dart';
import 'package:cardgame/HomePage.dart';
import 'CardAmountPage.dart';
import 'PlayerWalletClass.dart';
import 'package:provider/provider.dart';
import 'TexasGame.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return      MultiProvider(
        providers: [
        ChangeNotifierProvider<PlayerWallet>(
        create:(context)=>PlayerWallet(),
    )
    ],
    child:MaterialApp(
      initialRoute: HomePage.id,
      routes: {
        HomePage.id:(context)=> HomePage(),
        CardAmountPage.id:(context)=>CardAmountPage(),
        TexasGame.id:(context)=>TexasGame(),

      },
    ));
  }
}