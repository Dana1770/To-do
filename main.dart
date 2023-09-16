import 'package:flutter/material.dart';

void main() {
  runApp( BirthdayCard());
}

class BirthdayCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: Scaffold(
       backgroundColor: Color(0xFFFF4D0640),
body: Image(
  image: AssetImage("images/Happy-Birthday-Wishes.jpg"),height: 1000,width: 400,),
     ),
   );
  }

}

