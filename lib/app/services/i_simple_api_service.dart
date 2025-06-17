import 'package:default_projec/app/data/rest_reponse_model.dart';

abstract class ISimpleApiService {
  Future<RestReponseModel> getData(String endpoint);
  Future<RestReponseModel> createData(String endpoint, Map<String, dynamic> body);
   Future<RestReponseModel> updateData(String endpoint, String id, Map<String, dynamic> body);
  Future<RestReponseModel> deleteData(String endpoint, String id);
  Future<RestReponseModel> getDataById(String endpoint, String id);
}