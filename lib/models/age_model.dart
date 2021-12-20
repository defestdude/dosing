class AgeModel{
  final int id;
  final String title;


  AgeModel({this.id,this.title});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "title" : title
    };
  }
}