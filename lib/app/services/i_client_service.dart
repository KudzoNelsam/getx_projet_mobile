import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_simple_api_service.dart';

abstract class IClientService extends ISimpleApiService{
  Future<RestReponseModel> getClients({String? nom});
  Future<RestReponseModel> getClientById(int id);
  Future<RestReponseModel> createClient(Map<String, dynamic> body);
  Future<RestReponseModel> updateClient(int id, Map<String, dynamic> body);
  Future<RestReponseModel> deleteClient(int id);
  Future<RestReponseModel> searchClients(Map<String, dynamic> query);
}