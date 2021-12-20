class RegimenModel{
  final int id;
  final String regimen;


  RegimenModel({this.id,this.regimen});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "regimen" : regimen
    };
  }
}