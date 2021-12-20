class ARVDosageModel{
  final String drug;
  final String dose;
  final String route;
  final String duration;
  final String drug_instruction;


  ARVDosageModel({this.drug,this.dose, this.route, this.duration, this.drug_instruction});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "drug" : drug,
      "dose" : dose, 
      "route": route,
      "drug_instruction" : drug_instruction,
    };
  }
}