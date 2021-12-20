class ARVRiskModel{
  final int id;
  final String risk_type;


  ARVRiskModel({this.id,this.risk_type});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "risk_type" : risk_type
    };
  }
}