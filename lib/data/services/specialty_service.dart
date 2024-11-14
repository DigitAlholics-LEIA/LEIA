import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/specialty_model.dart';

class SpecialtyService {
  final String baseUrl =
      ''; // Reemplazar
  // Método para obtener todos los Specialty
  Future<List<Specialty>?> getAllSpecialties() async {
    final http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> maps = jsonResponse['content'];
      return maps.map((map) => Specialty.fromJson(map)).toList();
    } else {
      print("Error: ${response.statusCode}");
      return List.empty();
    }
  }

  // Método para obtener Specialty por ID
  Future<Specialty?> getSpecialtyById(int specialtyId) async {
    final String url = '$baseUrl/$specialtyId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      return Specialty.fromJson(jsonResponse);
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  }


}
