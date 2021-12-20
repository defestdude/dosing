class OIDosageModel{
  final String drug;
  final String dose;
  final String frequency;
  final String duration;
  final String strength;
  final String drug_instruction;
  final String no_of_tablets;


  OIDosageModel({this.drug,this.dose, this.frequency, this.duration, this.drug_instruction, this.strength, this.no_of_tablets});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "drug" : drug,
      "dose" : dose, 
      "frequency": frequency,
      "drug_instruction" : drug_instruction,
      "strength": strength,
      "no_of_tablets": no_of_tablets
    };
  }
}