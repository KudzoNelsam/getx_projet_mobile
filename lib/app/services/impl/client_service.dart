import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_client_service.dart';
import 'package:default_projec/app/services/impl/simple_api_service.dart';

class ClientService extends SimpleApiService implements IClientService{
  ClientService(super.baseUrl);

  @override
  Future<RestReponseModel> createClient(Map<String, dynamic> body) {
    return createData("clients", body);
  }


  @override
  Future<RestReponseModel> deleteClient(int id) {
    return deleteData("clients", id);
  }


  @override
  Future<RestReponseModel> getClientById(int id) {
    return getDataById("clients", id);
  }

  @override
  Future<RestReponseModel> getClients({String? nom}) {
    String endpoint = "clients";
    if (nom != null && nom.isNotEmpty) {
      endpoint += "?nom=$nom";
    }
    return getData(endpoint);
  }


  @override
  Future<RestReponseModel> searchClients(Map<String, dynamic> query) {
    String endpoint = "clients/search";
    if (query.isNotEmpty) {
      endpoint += "?${query.entries.map((e) => '${e.key}=${e.value}').join('&')}";
    }
    return getData(endpoint);
  }

  @override
  Future<RestReponseModel> updateClient(int id, Map<String, dynamic> body) {
    return updateData("clients", id, body);
  }

}