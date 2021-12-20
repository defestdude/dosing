import 'package:flutter/material.dart';
import 'package:nascp/utils/OnBoardingButtonClipper.dart';

class OnBoardingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
        width: 95,
        height: 95,
        decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF0C8863),
        Color(0xFF25BA76)
      ],
      stops: [
        0.4,
        1.0
      ]
    )
        ),
        child: Center(
    child: Padding(
      padding: EdgeInsets.only(left: 45),
      child: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
      )
    )
        ),
        
      );
  }
}