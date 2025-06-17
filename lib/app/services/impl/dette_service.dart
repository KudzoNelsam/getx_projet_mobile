import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_dette_service.dart';
import 'package:default_projec/app/services/impl/simple_api_service.dart';

class DetteService extends SimpleApiService implements IDetteService{
  DetteService(super.baseUrl);
  
  @override
  Future<RestReponseModel> createDette(Map<String, dynamic> body) {
    return createData("dettes", body);
  }
  
  @override
  Future<RestReponseModel> deleteDette(String id) {
    return deleteData("dettes", id);
  }
  
  @override
  Future<RestReponseModel> getAllDettes({String? clientId}) {
    String endpoint = "dettes";
    if (clientId != null) {
      endpoint += "?clientId=$clientId";
    }
    return getData(endpoint);
  }
  
  @override
  Future<RestReponseModel> getDetteById(String id) {
    return getDataById("dettes", id);
  }
  
  @override
  Future<RestReponseModel> searchDettes(Map<String, dynamic> query) {
    String endpoint = "dettes/search";
    if (query.isNotEmpty) {
      endpoint += "?${query.entries.map((e) => '${e.key}=${e.value}').join('&')}";
    }
    return getData(endpoint);
  }
  
  @override
  Future<RestReponseModel> updateDette(String id, Map<String, dynamic> body) {
    return updateData("dettes", id, body);
  }

  
}