import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';

class WelcomeScreen extends StatefulWidget{
  const WelcomeScreen({super.key});

@override
State<WelcomeScreen> createState() =>  _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> {
@override
void initState(){
  super.initState();

  Timer(const Duration(seconds:2),(){
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder:(context)=>const HomePage()),
  );


});
}
@override
Widget build(BuildContext context){
  return Scaffold(
    backgroundColor: const  Color(0xFFF7F8F4),
    body:Stack(
      children:[
        Positioned.fill(
          child: Image.asset(
           "assets/images/sky.jpg",
          fit:BoxFit.cover,
        ),
        ),
      
      Positioned.fill(
        child: Container(
          color:Colors.black.withOpacity(0.3),
        ),
        ),
       Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width:100,
              height:100,
              decoration: const BoxDecoration(
                color:Color(0xFF4E8B6B),
                shape:BoxShape.circle,

              ),
              child:const Icon(
                Icons.eco,
                color:Colors.white,
                size:50,
              ),
            ),
            const SizedBox (height:30),
            Container(
              width:280,
              padding:const EdgeInsets.symmetric(
                horizontal: 26,
                vertical:36,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow:const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 16,
                  offset:  Offset(0,4),
                ),
              ],
            ),
            child:const Text("Karbon Ayak İzi Sistemine\nHoş Geldiniz",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:24,
              height:2,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            ),
            ),
          ],
        )
      )
     ],
     ),
    );
   
}
}

