
import 'package:flutter/material.dart';
import 'package:nascp/screens/dosing_wheel/tb.dart';

import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/screens/dosing_wheel/regimens.dart';
import 'package:nascp/screens/dosing_wheel/search_result.dart';
import 'package:photo_view/photo_view.dart';



class AHD extends StatefulWidget {
    const AHD({Key key, this.weight, this.tb}) : super(key: key);

  // Declare a field that holds the Todo.
  final int weight;
  final String tb;

  @override
  _AHDState createState() => _AHDState();
}

class _AHDState extends State<AHD> {
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
      appBar: AppBar(title: Text("PEDS HIV Dosing Wheel"),automaticallyImplyLeading: false,),
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
           
          SizedBox(height: 15.0),
       //   Text('WHO 2020', style: TextStyle(fontFamily: 'Trueno', fontWeight: FontWeight.w500)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 125.0,
                  width: 200.0,
                  child: Stack(
                    children: [
                    
                      Text('Instructions For',
                          style: TextStyle(fontFamily: 'Trueno', fontSize: 20)),
                         
                      Positioned(
                        top: 29.0,
                        child: Text('AHD',
                            style: TextStyle(fontFamily: 'Trueno', fontSize: 35.0)),
                      ),
                  
                    ],
                  )),
                 
            ],
          ),
          SizedBox(height: 5.0),
                 Text("All children less than 5 years are considered to have AHD and have an increased risk of disease progression and mortality. For children between 5 - 9 years, a positive HIV test should be followed with a CD4+ test and clinical evaluation to assess for AHD. Those with WHO clinical stage 3 or 4 or CD4 <200cells/ml have AHD "),
                  SizedBox(height: 10.0),
                 Text("Offer the screening tests as outlined below, and where applicable, provide prophylaxis, treatment and vaccination based on the outcome of the screening to all children <5 years and all children 5 - 9years with AHD as outlined below "),
InteractiveViewer(
  maxScale: 10,
  child: Image.asset("assets/documents/pead.png"),),
  SizedBox(height: 5.0),
  RichText(
  text: TextSpan(
    style: TextStyle(fontFamily: 'Trueno', color: Colors.black, fontSize: 13),
    children: [
      WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, -7.0),
          child: Text(
            'a',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TextSpan(
        text: 'Evidence indicates that adolescent females living with perinatally-acquired HIV have a higher prevalence of high-risk HPV and abnormal cervical cytology than uninfected adolescents. WHO recommends a three-dose series (0, 1–2 and 6 months) for females older than nine years living with HIV rather than the standard two-dose series.',
   ),
    ],
  ),
),
  SizedBox(height: 5.0),
     RichText(
  text: TextSpan(
    style: TextStyle(fontFamily: 'Trueno', color: Colors.black, fontSize: 13),
    children: [
      WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, -7.0),
          child: Text(
            'b',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TextSpan(
        text: 'only if the child missed birth and early childhood dose.',
   ),
    ],
  ),
),
  SizedBox(height: 5.0), 

   RichText(
  text: TextSpan(
    style: TextStyle(fontFamily: 'Trueno', color: Colors.black, fontSize: 13),
    children: [
      WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, -7.0),
          child: Text(
            'c',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TextSpan(
        text: 'To be discontinued when CD4+ cell count >350 and viral load suppressed for at least 6 months.',
   ),
    ],
  ),
),
          SizedBox(height: 5.0),
RichText(
  text: TextSpan(
    style: TextStyle(fontFamily: 'Trueno', color: Colors.black, fontSize: 13),
    children: [
      WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, -7.0),
          child: Text(
            'd',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TextSpan(
        text: 'TB preventive treatment is currently not recommended for infants living with HIV younger than 12 months of age unless they have a known TB contact.',
   ),
    ],
  ),
),
SizedBox(height: 5.0),
RichText(
  text: TextSpan(
    style: TextStyle(fontFamily: 'Trueno', color: Colors.black, fontSize: 13),
    children: [
      WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, -7.0),
          child: Text(
            'e',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TextSpan(
        text: 'Defer ART in children with AHD who present with TB, severe acute malnutrition or other illnesses that require hospitalization need to be stabilized first. However, initiating ART is encouraged as part of the child\'s hospital admission.',
   ),
    ],
  ),
),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              if (widget.tb == "NO") {
                Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Regimens(weight: widget.weight,),
        ));
              } else {
                  Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TB(weight: widget.weight,),
        ));
              }
               
              //if (checkFields()) AuthService().signIn(email, password, context);
            },
            child: Container(
                height: 50.0,
                width: 350,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.greenAccent,
                    color: greenColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('PROCEED',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
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
              
             /* Container(
                width: 120,
                margin: EdgeInsets.only(right: 10),
                height: categoryHeight,
                decoration: BoxDecoration(color: Color(0xFF0C8863), border: Border.all(color: Colors.black45), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Postnatal Infant ARV Prophylaxis",
                        style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'Trueno'),
                      ),
                     Center(
                        child: ImageIcon(AssetImage('assets/images/prophy.png'),
                                size: 35.0, color: Color(0xFFFFFFFF)),
                      )
                     
                    ],
                  ),
                ),
              ),*/
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
