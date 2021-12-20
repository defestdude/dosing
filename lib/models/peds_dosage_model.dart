class PedsDosageModel{
  final String drug;
  final String dose;
  final String strength;
  final String weightBand;
  final String instructions;
  final int has_image;


  PedsDosageModel({this.drug,this.dose, this.strength, this.weightBand, this.instructions, this.has_image});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "drug" : drug,
      "dose" : dose, 
      "strength": strength,
      "weight_band" : weightBand,
      "instructions": instructions,
      "has_image": has_image
    };
  }
}