import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_simple_api_service.dart';

abstract class ILigneService extends ISimpleApiService{
  Future<RestReponseModel> getAllLignes({int? detteId});
  Future<RestReponseModel> getLigneById(int id);
  Future<RestReponseModel> createLigne(Map<String, dynamic> body);
  Future<RestReponseModel> updateLigne(int id, Map<String, dynamic> body);
  Future<RestReponseModel> deleteLigne(int id);
  Future<RestReponseModel> searchLignes(Map<String, dynamic> query);
}