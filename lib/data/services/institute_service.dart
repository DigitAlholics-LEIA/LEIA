import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/institute_model.dart';


class InstituteService {
  final String baseUrl = '';

  // Método para obtener todos los institutos
  Future<List<Institute>?> getAllInstitutes() async {
    try {
      final http.Response response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data']; // Ajusta según la estructura de tu API
        return data.map((item) => Institute.fromJson(item)).toList();
      } else {
        print("Error al obtener institutos: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error al obtener institutos: $e");
      return null;
    }
  }


  // Método para obtener un instituto por ID
  Future<Institute?> getInstituteById(int id) async {
    final String url = '$baseUrl/$id';

    try {
      final http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(response.body);
        return Institute.fromJson(jsonResponse);
      } else {
        print("Error al obtener instituto por ID: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error al obtener instituto por ID: $e");
      return null;
    }
  }
}
