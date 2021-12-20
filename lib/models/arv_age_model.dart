class ARVAgeModel{
  final int id;
  final String arv_age;


  ARVAgeModel({this.id,this.arv_age});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "arv_age" : arv_age
    };
  }
}