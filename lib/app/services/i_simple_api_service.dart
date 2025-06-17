import 'package:default_projec/app/data/rest_reponse_model.dart';

abstract class ISimpleApiService {
  Future<RestReponseModel> getData(String endpoint);
  Future<RestReponseModel> createData(String endpoint, Map<String, dynamic> body);
   Future<RestReponseModel> updateData(String endpoint, int id, Map<String, dynamic> body);
  Future<RestReponseModel> deleteData(String endpoint, int id);
  Future<RestReponseModel> getDataById(String endpoint, int id);
}