import 'package:flutter/material.dart';
import 'package:nascp/screens/home_screen.dart';
import 'package:nascp/screens/main_home.dart';
import 'package:nascp/utils/OnBoardingImageClipper.dart';
import 'package:nascp/widgets/onBoardingButton.dart';
import 'package:google_fonts/google_fonts.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          ClipPath(
              clipper: OnBoardingImageClipper(),
              child: Stack(children: <Widget>[
                Image.asset(
                  "assets/images/img2.jpg",
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.85,
                ),
                Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    left: 0.0,
                    top: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Nigeria ",
                              style: GoogleFonts.ruluko(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 46),
                            ),
                            
                          ],
                        ),
                        Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                "HIV Management ",
                                style: GoogleFonts.ruluko(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30),
                              ),
                            ),
                        SizedBox(height: 10),
                          Text("Portal",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30)),
                                  SizedBox(height: 30),
                        IconButton(
                            icon: Icon(Icons.login),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => MainHome()));
                            }),
                      
                      
                      ],
                    ))
              ])),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/coa.jpg",
                            fit: BoxFit.fitWidth, width: 80),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/logo2.png",
                              fit: BoxFit.fitWidth, width: 200),
                        ),
                      ],
                    ),
                    Container(
                      height: 2.0,
                      width: 250,
                      color: Color(0xffe0b644),
                    ),
                    Text("Federal Ministry of Health",
                        style: TextStyle(
                            letterSpacing: 3.4,
                            fontFamily: "Trueno",
                            color: Color(0xff33a082),
                            fontWeight: FontWeight.w700))
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => MainHome()));
                      },
                      child: Image.asset("assets/images/hiv.png",
                          fit: BoxFit.fitWidth,
                          width: 50), /*OnBoardingButton()*/
                    )
                  ],
                )
              ])
        ]));
  }
}
