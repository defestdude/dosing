import 'package:flutter/material.dart';
import 'package:nascp/constants.dart';
import 'package:nascp/screens/book_read.dart';
import 'package:nascp/utils/configuration.dart';
import 'package:nascp/widgets/book_rating.dart';
import 'package:nascp/widgets/rounded_button.dart';

class BookDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Container(

                    decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)
                  )
                ),
                   
                  )
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("The Government of Nigeria is deeply committed to providing high quality and comprehensive care for its population of people living with HIV/AIDS. This commitment is evident in the steps government has taken to combat HIV/AIDS since the virus was discovered in the country in 1986. In response to the discovery of HIV, Government took immediate steps to establish the National Expert Committee on AIDS and the National AIDS Control Programme in 1986. Thereafter, the National Action Committee on AIDS which is now the National Agency for the Control of AIDs was established to oversee the multisectoral response to HIV/AIDS and jointly these organs of government have managed a well coordinated effort to contain the HIV epidemic in Nigeria.",
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kLightBlackColor
                      )),
                    )
                  )
                )
              ]
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {}
                  )
                ],
              )
            )
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * .1),
                  BookInfo()            
                ]
              )
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 90,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowList,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("National Guidelines for HIV/AIDs Treatment",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800
                    )
                    ),
                    SizedBox(height: 10),
                    Text("2010", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kLightBlackColor))

                  ],
                ),
              )
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                )
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryGreen,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BookRead(1, "National Acceleration Plan for Pediatric and Adeoescent HIV Treatment & Care");
                                    }
                                  )
                                );
                          },
                                                  child: Text('Download',
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      )
                    )
                  )
                ],
              )
            )
          )
        ]
      )
    );
  }
}

class BookInfo extends StatelessWidget {
  const BookInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: Column(children: <Widget>[
        Text("HIV Prevention and Cure",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
            )),
        SizedBox(height: 5),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Expanded(
              child: Column(children: <Widget>[
            Text(
                "The Government of Nigeria is deeply committed to providing high quality and comprehensive care for its population of people living with HIV/AIDS.",
                maxLines: 5,
                style: TextStyle(fontSize: 11, color: kLightBlackColor)),
            SizedBox(height: 5),
            RoundedButton(text: "Read", verticalPadding: 10)
          ])),
          Column(children: <Widget>[
            IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
            BookRating(score: 4.9)
          ])
        ])
      ])),
      Image.asset(
        "assets/images/book_1.png",
        height: 200,
      )
    ]);
  }
}
