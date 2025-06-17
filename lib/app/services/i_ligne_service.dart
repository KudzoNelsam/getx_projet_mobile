import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_simple_api_service.dart';

abstract class ILigneService extends ISimpleApiService{
  Future<RestReponseModel> getAllLignes({String? detteId});
  Future<RestReponseModel> getLigneById(String id);
  Future<RestReponseModel> createLigne(Map<String, dynamic> body);
  Future<RestReponseModel> updateLigne(String id, Map<String, dynamic> body);
  Future<RestReponseModel> deleteLigne(String id);
  Future<RestReponseModel> searchLignes(Map<String, dynamic> query);
  Future<RestReponseModel> getLignesByDetteId(String detteId);
}