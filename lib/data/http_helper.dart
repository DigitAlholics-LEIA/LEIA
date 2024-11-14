import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/institute_model.dart';
import 'model/specialty_model.dart';



class HttpHelper {
  final String urlBase = 'http://localhost:3000/api';

  // Fetch specialty by ID
 Future<Specialty> getSpecialty() async {
    
    final String url = '$urlBase/speciality';

    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.get(
        Uri.parse(url)
      );
      if (response.statusCode == 200) {
        final decodedData = utf8.decode(response.bodyBytes);
        final jsonResponse = json.decode(decodedData);
        print(response.body);
        return Specialty.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to get specialty. Status code: ${response.statusCode}');
      }
    } catch (exception) {
      print('Error: $exception');
      throw Exception('Failed to get specialty.');
    }
  }

  // Fetch institution by Specialty ID
  Future<List<Institute>> getInstitutionsBySpecialtyId(int specialtyId) async {
  final url = Uri.parse('$urlBase/institution/getBySpecialityId/$specialtyId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as List;

    // Convertir los datos JSON en una lista de objetos Institute usando Institute.fromJson
    return data.map((instituteData) => Institute.fromJson(instituteData)).toList();
  } else {
    throw Exception('Failed to load institutions');
  }
}
}
