
import 'package:flutter/material.dart';
import 'package:nascp/screens/dosing_wheel/arv_prophy.dart';
import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/screens/dosing_wheel/oi_prophy.dart';
import 'package:nascp/screens/dosing_wheel/peds_art.dart';
import 'package:nascp/screens/dosing_wheel/regimens.dart';
import 'package:nascp/screens/dosing_wheel/search_result.dart';


class DWLHome extends StatefulWidget {
  @override
  _DWLHomeState createState() => _DWLHomeState();
}

class _DWLHomeState extends State<DWLHome> {
   final CategoriesScroller categoriesScroller = CategoriesScroller();
  final formKey = new GlobalKey<FormState>();

  String email, password;
  bool closeTopContainer = false;
  Color greenColor = Color(0xFF0C8863);
  Color lightGreen = Color(0xFF10B875);
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 
  String _chosenValue;

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return Scaffold(
       key: _scaffoldKey,    
      drawer: DrawerScreen(),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildLoginForm())));
  }

  _buildLoginForm() {
     final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                   _scaffoldKey.currentState.openDrawer();
                }),
            ),
           
          SizedBox(height: 55.0),
          Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 125.0,
                  width: 200.0,
                  child: Stack(
                    children: [
                    
                      Text('Paediatrics HIV',
                          style: TextStyle(fontFamily: 'Trueno', fontSize: 20)),
                         
                      Positioned(
                        top: 20.0,
                        child: Text('Dosing',
                            style: TextStyle(fontFamily: 'Trueno', fontSize: 50.0)),
                      ),
                      Positioned(
                          top: 70.0,
                          child: Text('Guide',
                              style:
                                  TextStyle(fontFamily: 'Trueno', fontSize: 50.0))),
                      Positioned(
                          top: 97.0,
                          left: 175.0,
                          child: ImageIcon(AssetImage('assets/images/hiv.png'),
                                  size: 15.0))
                    ],
                  )),
                  Image.asset('assets/images/coa.png', width: 100)
                 
            ],
          ),
           SizedBox(height: 25.0),
             GestureDetector(
               onTap: () {
               Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PedsART()));
              },
               child: Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 20),
                  //height: MediaQuery.of(context).size.height * 0.30 - 150,
                  decoration: BoxDecoration(color: Color(0xFFFFFFFF), border: Border.all(color: Colors.black45), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Image.asset('assets/images/peds1.png', width: 50)
                        ),
                       Center(
                         child: Text(
                            "Paediatrics ART",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black, fontFamily: 'Trueno',),
                          ),
                       ),
                       
                      ],
                    ),
                  ),
                ),
             ),
               SizedBox(height: 25.0),
               GestureDetector(
                 onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OIProphy()));
              },
                 child: Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 20),
                  //height: MediaQuery.of(context).size.height * 0.30 - 150,
                  decoration: BoxDecoration(color: Color(0xFFFFFFFF), border: Border.all(color: Colors.black45), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Image.asset('assets/images/art.png', width: 50)
                        ),
                       Center(
                         child: Text(
                            "OI Prophylaxis",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black, fontFamily: 'Trueno',),
                          ),
                       ),
                       
                      ],
                    ),
                  ),
              ),
               ),
              SizedBox(height: 25.0),
               GestureDetector(
                  onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ARVProphy()));
              },
                 child: Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 20),
                  //height: MediaQuery.of(context).size.height * 0.30 - 150,
                  decoration: BoxDecoration(color: Color(0xFFFFFFFF), border: Border.all(color: Colors.black45), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Image.asset('assets/images/prophy1.png', width: 60)
                        ),
                       Center(
                         child: Text(
                            "Postnatal ARV Prophylaxis",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black, fontFamily: 'Trueno',),
                          ),
                       ),
                       
                      ],
                    ),
                  ),
              ),
               ),
          ],),
       //   Text('WHO 2020', style: TextStyle(fontFamily: 'Trueno', fontWeight: FontWeight.w500)),
         

         
          SizedBox(height: 20.0),
       
          
   

       
        ]));
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 150;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
            
              Container(
                width: 120,
                margin: EdgeInsets.only(right: 10),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black45), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Center(
                        child:  Image.asset('assets/images/who.png', width: 50)
                      ),
                       Center(
                         child: Text(
                          "WHO Guidelines",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.black, fontFamily: 'Trueno'),
                      ),
                       ),
                     
                       
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 120,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Color(0xFFFFFFFF), border: Border.all(color: Colors.black45), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Image.asset('assets/images/coa.png', width: 50)
                      ),
                     Center(
                       child: Text(
                          "National HIV Treatment Guidelines",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black, fontFamily: 'Trueno',),
                        ),
                     ),
                     
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
