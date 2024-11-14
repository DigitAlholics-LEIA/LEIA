

class Specialty {
  int id;
  String name;
  DateTime startDate;
  DateTime endDate;
  String typeSpecialty;

  Specialty({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.typeSpecialty,
  });

  // Constructor para crear una instancia desde JSON
  Specialty.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['Name'],
          startDate: DateTime.parse(json['StartDate']),
          endDate: DateTime.parse(json['EndDate']),
          typeSpecialty: json['Type'],
        );

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'typeSpecialty': typeSpecialty,
    };
  }

  
}
