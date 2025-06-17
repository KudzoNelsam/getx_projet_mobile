import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_simple_api_service.dart';

abstract class IDetteService extends ISimpleApiService{
  Future<RestReponseModel> getAllDettes({String? clientId});
  Future<RestReponseModel> getDetteById(String id);
  Future<RestReponseModel> createDette(Map<String, dynamic> body);
  Future<RestReponseModel> updateDette(String id, Map<String, dynamic> body);
  Future<RestReponseModel> deleteDette(String id);
  Future<RestReponseModel> searchDettes(Map<String, dynamic> query);
}