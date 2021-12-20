class ARVWeightModel{
  final int id;
  final String arv_weight;


  ARVWeightModel({this.id,this.arv_weight});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "arv_weight" : arv_weight
    };
  }
}