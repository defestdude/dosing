import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final double verticalPadding;
  final double fontSize;
  
  const RoundedButton({
    Key key,
    this.text, this.press, this.verticalPadding = 10, this.fontSize = 12
    }) : super (key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        
        margin: EdgeInsets.symmetric(vertical: 12),
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 30,
              color: Color(0xFF666666).withOpacity(.11)
            )
          ]
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)
        )
      )

    );
  }
}