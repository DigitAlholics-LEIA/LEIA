import 'specialty_model.dart';

class Institute {
   int id;
   String name;
   String brand;
   String description;
   int cycles;
   double prices;
   String location;
   Specialty specialty;

  

   Institute({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.cycles,
    required this.prices,
    required this.location,
    required this.specialty,
  });

    // Constructor para crear una instancia desde JSON
  Institute.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      brand= json['brand'],
      description = json['description'],
      cycles = json['cycles'],
      prices = json['price'],
      location = json['location'],
      specialty = Specialty.fromJson(json['specialty']);


}