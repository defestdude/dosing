class WeightModel{
  final int id;
  final String weight_band;


  WeightModel({this.id,this.weight_band});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "weight_band" : weight_band
    };
  }
}