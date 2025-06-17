import 'dart:convert';
import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_simple_api_service.dart';
import 'package:http/http.dart' as http;

class SimpleApiService implements ISimpleApiService {
  final String baseUrl;

  SimpleApiService(this.baseUrl);

  // Récupérer (GET)
  Future<RestReponseModel> getData(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return RestReponseModel(
          statusCode: 200,
          message: "Succès",
          data: json.decode(response.body),
        );
      } else {
        return RestReponseModel(
          statusCode: response.statusCode,
          message: "Erreur lors de la récupération des données",
          data: null,
        );
      }
    } catch (e) {
      return RestReponseModel(
        statusCode: 500,
        message: "Exception : $e",
        data: null,
      );
    }
  }

  // Créer (POST)
  Future<RestReponseModel> createData(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      if (response.statusCode == 201) {
        return RestReponseModel(
          statusCode: 201,
          message: "Création réussie",
          data: json.decode(response.body),
        );
      } else {
        return RestReponseModel(
          statusCode: response.statusCode,
          message: "Erreur lors de la création",
          data: null,
        );
      }
    } catch (e) {
      return RestReponseModel(
        statusCode: 500,
        message: "Exception : $e",
        data: null,
      );
    }
  }

  // Modifier (PUT)
  Future<RestReponseModel> updateData(String endpoint, String id, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/$endpoint/$id');
    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        return RestReponseModel(
          statusCode: 200,
          message: "Modification réussie",
          data: json.decode(response.body),
        );
      } else {
        return RestReponseModel(
          statusCode: response.statusCode,
          message: "Erreur lors de la modification",
          data: null,
        );
      }
    } catch (e) {
      return RestReponseModel(
        statusCode: 500,
        message: "Exception : $e",
        data: null,
      );
    }
  }

  // Supprimer (DELETE)
  Future<RestReponseModel> deleteData(String endpoint, String id) async {
    final url = Uri.parse('$baseUrl/$endpoint/$id');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        return RestReponseModel(
          statusCode: 200,
          message: "Suppression réussie",
          data: null,
        );
      } else {
        return RestReponseModel(
          statusCode: response.statusCode,
          message: "Erreur lors de la suppression",
          data: null,
        );
      }
    } catch (e) {
      return RestReponseModel(
        statusCode: 500,
        message: "Exception : $e",
        data: null,
      );
    }
  }
  
  @override
  Future<RestReponseModel> getDataById(String endpoint, String id) {
    final url = Uri.parse('$baseUrl/$endpoint/$id');
    return http.get(url).then((response) {
      if (response.statusCode == 200) {
        return RestReponseModel(
          statusCode: 200,
          message: "Succès",
          data: json.decode(response.body),
        );
      } else {
        return RestReponseModel(
          statusCode: response.statusCode,
          message: "Erreur lors de la récupération des données",
          data: null,
        );
      }
    }).catchError((e) {
      return RestReponseModel(
        statusCode: 500,
        message: "Exception : $e",
        data: null,
      );
    });
  }
}