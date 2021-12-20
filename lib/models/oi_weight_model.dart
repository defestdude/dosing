class OIWeightModel{
  final int id;
  final String weight;


  OIWeightModel({this.id,this.weight});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "weight" : weight
    };
  }
}