import 'package:flutter/material.dart';
import 'package:nascp/constants.dart';
import 'package:nascp/widgets/book_rating.dart';
import 'package:nascp/widgets/two_side_rounded_button.dart';

class PoliciesCard3 extends StatelessWidget {
  final String image;
  final String title;
  final String auth;
  final double rating;
  final Function pressDetails;
  final Function pressRead;
  
  const PoliciesCard3({
    Key key, this.image, this.title, this.auth, this.rating, this.pressDetails, this.pressRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
        margin: EdgeInsets.only(left: 24, bottom: 40),
        height: 265,
        width: 202,
        child: Stack(
    children: <Widget>[
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 221,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(29),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 33,
                color: kShadowColor
              )
            ]
          )
        ),
      ),
      Image.asset(image,
        width: 150,
      ),
     
      Positioned(
        top: 160,
        child: Container(
          height: 105, width: 202, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: RichText(
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(color: kBlackColor),
                    children: [
                      TextSpan(text: title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      )
                      ),
                      TextSpan(
                        text: auth,
                        style: TextStyle(
                          color: kLightBlackColor,
                        )
                      )
                    ]
                  )
                ),
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Container(
                  width: 101,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text("Details")
                    ),
                  Expanded(
                    child: TwoSideRoundedButton(
                      text: "Download",
                      press: pressRead,

                    )
                  )
                ]
              )
            ]
          )
        )
        )
    ]
        ));
  }
}
