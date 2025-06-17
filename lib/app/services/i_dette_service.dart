import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_simple_api_service.dart';

abstract class IDetteService extends ISimpleApiService{
  Future<RestReponseModel> getAllDettes({int? clientId});
  Future<RestReponseModel> getDetteById(int id);
  Future<RestReponseModel> createDette(Map<String, dynamic> body);
  Future<RestReponseModel> updateDette(int id, Map<String, dynamic> body);
  Future<RestReponseModel> deleteDette(int id);
  Future<RestReponseModel> searchDettes(Map<String, dynamic> query);
}